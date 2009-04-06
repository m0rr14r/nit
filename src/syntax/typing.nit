# This file is part of NIT ( http://www.nitlanguage.org ).
#
# Copyright 2008 Jean Privat <jean@pryen.org>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Analysis property bodies, statements and expressions
package typing

import syntax_base

redef class MMSrcModule
	# Walk trough the module and type statments and expressions
	# Require than supermodules are processed
	meth do_typing(tc: ToolContext)
	do
		var tv = new TypingVisitor(tc, self)
		tv.visit(node)
	end
end

# Typing visitor
# * Associate local variables to nodes
# * Distinguish method call and local variable access
# * Resolve call and attribute access
# * Check type conformance
private class TypingVisitor
special AbsSyntaxVisitor
	redef meth visit(n)
	do
		if n != null then n.accept_typing(self)
	end

	# Current knowledge about variables names and types
	readable writable attr _variable_ctx: VariableContext

	# The current reciever
	readable writable attr _self_var: ParamVariable

	# Block of the current method
	readable writable attr _top_block: PExpr

	# Current closure (if any)
	readable writable attr _closure: MMClosure

	# Current closure method return type (for break) (if any)
	readable writable attr _closure_break_stype: MMType = null

	# Current closure break expressions (if any)
	readable writable attr _break_list: Array[PExpr]

	# List of explicit invocation of constructors of super-classes
	readable writable attr _explicit_super_init_calls: Array[MMMethod]

	# Is a other constructor of the same class invoked
	readable writable attr _explicit_other_init_call: Bool

	init(tc, module) do super

	private meth get_default_constructor_for(n: PNode, c: MMLocalClass, prop: MMSrcMethod): MMMethod
	do
		var v = self
		#var prop = v.local_property
		#assert prop isa MMMethod
		var candidates = new Array[MMMethod]
		var false_candidates = new Array[MMMethod]
		var parity = prop.signature.arity
		for g in c.global_properties do
			if not g.is_init_for(c) then continue
			var gp = c[g]
			var gps = gp.signature_for(c.get_type)
			assert gp isa MMSrcMethod
			var garity = gps.arity
			if prop != null and gp.name == prop.name then
				if garity == 0 or (parity == garity and prop.signature < gps) then
					return gp
				else
					false_candidates.add(gp)
				end
			else if garity == 0 and gp.name == once ("init".to_symbol) then
				candidates.add(gp)
				false_candidates.add(gp)
			else
				false_candidates.add(gp)
			end
		end
		if candidates.length == 1 then
			return candidates.first
		else if candidates.length > 0 then
			var a = new Array[String]
			for p in candidates do
				a.add("{p.full_name}{p.signature}")
			end
			v.error(n, "Error: Conflicting default constructor to call for {c}: {a.join(", ")}.")
			return null
		else if false_candidates.length > 0 then
			var a = new Array[String]
			for p in false_candidates do
				a.add("{p.full_name}{p.signature}")
			end
			v.error(n, "Error: there is no available compatible constrctor in {c}. Discarded candidates are {a.join(", ")}.")
			return null
		else
			v.error(n, "Error: there is no available compatible constrctor in {c}.")
			return null
		end
	end
end

# Associate symbols to variable and variables to type
# Can be nested
private class VariableContext
	# Look for the variable from its name
	# Return null if nothing found
	meth [](s: Symbol): Variable
	do
		if _dico.has_key(s) then
			return _dico[s]
		else
			return null
		end
	end

	# Register a new variable with its name
	meth add(v: Variable)
	do
		_dico[v.name] = v
	end


	# The effective static type of a given variable
	# May be different from the declaration static type
	meth stype(v: Variable): MMType
	do
		return v.stype
	end

	# Variables by name (in the current context only)
	attr _dico: Map[Symbol, Variable]

	# Build a new VariableContext
	meth sub: SubVariableContext
	do
		return new SubVariableContext.with_prev(self, null, null)
	end

	# Build a nested VariableContext with new variable information
	meth sub_with(v: Variable, t: MMType): SubVariableContext
	do
		return new SubVariableContext.with_prev(self, v, t)
	end

	init
	do 
		_dico = new HashMap[Symbol, Variable]
	end
end

private class SubVariableContext
special VariableContext
	readable attr _prev: VariableContext
	attr _variable: Variable
	attr _var_type: MMType

	redef meth [](s)
	do
		if _dico.has_key(s) then
			return _dico[s]
		else
			return prev[s]
		end
	end

	redef meth stype(v)
	do
		if _variable == v then
			return _var_type
		end
		return prev.stype(v)
	end

	init with_prev(p: VariableContext, v: Variable, t: MMType)
	do
		init
		_prev = p
		_variable = v
		_var_type =t
	end
end


###############################################################################

redef class PNode
	private meth accept_typing(v: TypingVisitor) 
	do
		accept_abs_syntax_visitor(v)
		after_typing(v)
	end
	private meth after_typing(v: TypingVisitor) do end
end

redef class PClassdef
	redef meth accept_typing(v)
	do
		v.self_var = new ParamVariable("self".to_symbol, self)
		v.self_var.stype = local_class.get_type
		super
	end
end

redef class AAttrPropdef
	redef meth accept_typing(v)
	do
		super
		if n_expr != null then
			v.check_conform_expr(n_expr, prop.signature.return_type)
		end
	end
end

redef class AMethPropdef
	redef readable attr _self_var: ParamVariable
	redef meth accept_typing(v)
	do
		v.variable_ctx = new VariableContext
		_self_var = v.self_var
		super
	end
end

redef class AConcreteInitPropdef
	readable attr _super_init_calls: Array[MMMethod] = new Array[MMMethod]
	readable attr _explicit_super_init_calls: Array[MMMethod] = new Array[MMMethod]
	redef meth accept_typing(v)
	do
		v.top_block = n_block
		v.explicit_super_init_calls = explicit_super_init_calls
		v.explicit_other_init_call = false
		super
		if v.explicit_other_init_call or method.global.intro != method then
			# TODO: something?
		else 
			var i = 0
			var l = explicit_super_init_calls.length
			var cur_m: MMMethod = null
			var cur_c: MMLocalClass = null
			if i < l then
				cur_m = explicit_super_init_calls[i]
				cur_c = cur_m.global.intro.local_class.for_module(v.module)
			end
			var j = 0
			while j < v.local_class.cshe.direct_greaters.length do
				var c = v.local_class.cshe.direct_greaters[j]
				if c.global.is_interface or c.global.is_universal or c.global.is_mixin then
					j += 1
				else if cur_c != null and (c.cshe <= cur_c or cur_c.global.is_mixin) then
					if c == cur_c then j += 1
					super_init_calls.add(cur_m)
					i += 1
					if i < l then
						cur_m = explicit_super_init_calls[i]
						cur_c = cur_m.global.intro.local_class.for_module(v.module)
					else
						cur_m = null
						cur_c = null
					end
				else
					var p = v.get_default_constructor_for(self, c, method)
					if p != null then
						super_init_calls.add(p)
					end
					j += 1
				end
			end
		end
	end
end

redef class PParam
	redef meth after_typing(v)
	do
		# TODO: why the test?
		if v.variable_ctx != null then
			v.variable_ctx.add(variable)
		end
	end
end

redef class AClosureDecl
	redef meth accept_typing(v)
	do
		# Register the closure for ClosureCallExpr
		v.variable_ctx.add(variable)

		var old_var_ctx = v.variable_ctx
		v.variable_ctx = v.variable_ctx.sub
		v.closure = variable.closure

		super

		v.variable_ctx = old_var_ctx
		v.closure = null
	end
end

redef class PType
	readable attr _stype: MMType
	redef meth after_typing(v)
	do
		_stype = get_stype(v)
	end
end

redef class PExpr
	redef readable attr _stype: MMType
	
	# Is the expression the implicit receiver
	meth is_implicit_self: Bool do return false

	# Is the expression the current receiver (implicit or explicit)
	meth is_self: Bool do return false

	# The variable accessed is any
	meth its_variable: Variable do return null

	# The variable type information if current boolean expression is true
	readable private attr _if_true_variable_ctx: VariableContext
end

redef class AVardeclExpr
	redef meth after_typing(v)
	do
		var va = new VarVariable(n_id.to_symbol, self)
		variable = va
		v.variable_ctx.add(va)

		if n_type != null then
			va.stype = n_type.stype
			if n_expr != null then
				v.check_conform_expr(n_expr, va.stype)
			end
		else
			v.check_expr(n_expr)
			va.stype = n_expr.stype
		end
	end
end

redef class ABlockExpr
	redef meth accept_typing(v)
	do
		var old_var_ctx = v.variable_ctx
		v.variable_ctx = v.variable_ctx.sub

		super

		v.variable_ctx = old_var_ctx
	end
end

redef class AReturnExpr
	redef meth after_typing(v)
	do
		var t = v.local_property.signature.return_type
		if n_expr == null and t != null then
			v.error(self, "Error: Return without value in a function.")
		else if n_expr != null and t == null then
			v.error(self, "Error: Return with value in a procedure.")
		else if n_expr != null and t != null then
			v.check_conform_expr(n_expr, t)
		end
	end
end

redef class AContinueExpr
	redef meth after_typing(v)
	do
		var c = v.closure
		var t: MMType = null
		if c != null then 
			if c.is_break then
				v.error(self, "Error: 'continue' forbiden in break blocks.")
				return
			end
			t = c.signature.return_type
		end

		if n_expr == null and t != null then
			v.error(self, "Error: continue with a value required in this bloc.")
		else if n_expr != null and t == null then
			v.error(self, "Error: continue without value required in this bloc.")
		else if n_expr != null and t != null then
			v.check_conform_expr(n_expr, t)
		end
	end
end

redef class ABreakExpr
	redef meth after_typing(v)
	do
		var t = v.closure_break_stype
		if n_expr == null and t != null then
			v.error(self, "Error: break with a value required in this bloc.")
		else if n_expr != null and t == null then
			v.error(self, "Error: break without value required in this bloc.")
		else if n_expr != null and t != null then
			# Typing check can only be done later
			v.break_list.add(n_expr)
		end
	end
end

redef class AIfExpr
	redef meth accept_typing(v)
	do
		var old_var_ctx = v.variable_ctx
		v.visit(n_expr)
		v.check_conform_expr(n_expr, v.type_bool)

		if n_expr.if_true_variable_ctx != null then
			v.variable_ctx = n_expr.if_true_variable_ctx
		end

		v.visit(n_then)
		# Restore variable ctx
		v.variable_ctx = old_var_ctx

		if n_else != null then
			v.visit(n_else)
			v.variable_ctx = old_var_ctx
		end
	end
end

redef class AWhileExpr
	redef meth after_typing(v)
	do
		v.check_conform_expr(n_expr, v.type_bool)
	end
end

redef class AForExpr
	readable attr _meth_iterator: MMMethod
	readable attr _meth_is_ok: MMMethod
	readable attr _meth_item: MMMethod
	readable attr _meth_next: MMMethod
	redef meth accept_typing(v)
	do
		v.variable_ctx = v.variable_ctx.sub
		var va = new AutoVariable(n_id.to_symbol, self)
		variable = va
		v.variable_ctx.add(va)

		v.visit(n_expr)

		var expr_type = n_expr.stype
		if not v.check_conform_expr(n_expr, v.type_collection) then
			return
		end
		_meth_iterator = expr_type.local_class.select_method(once ("iterator".to_symbol))
		if _meth_iterator == null then
			v.error(self, "Error: Collection MUST have an iterate method")
			return
		end
		var iter_type = _meth_iterator.signature_for(expr_type).return_type
		_meth_is_ok = iter_type.local_class.select_method(once ("is_ok".to_symbol))
		if _meth_is_ok == null then
			v.error(self, "Error: {iter_type} MUST have an is_ok method")
			return
		end
		_meth_item = iter_type.local_class.select_method(once ("item".to_symbol))
		if _meth_item == null then
			v.error(self, "Error: {iter_type} MUST have an item method")
			return
		end
		_meth_next = iter_type.local_class.select_method(once ("next".to_symbol))
		if _meth_next == null then
			v.error(self, "Error: {iter_type} MUST have a next method")
			return
		end
		var t = _meth_item.signature_for(iter_type).return_type
		if not n_expr.is_self then t = t.not_for_self
		va.stype = t

		if n_block != null then v.visit(n_block)

		# pop context
		var varctx = v.variable_ctx 
		assert varctx isa SubVariableContext
		v.variable_ctx = varctx.prev
	end
end

redef class AAssertExpr
	redef meth after_typing(v)
	do
		v.check_conform_expr(n_expr, v.type_bool)
		if n_expr.if_true_variable_ctx != null then v.variable_ctx = n_expr.if_true_variable_ctx
	end
end

redef class AVarExpr
	redef meth its_variable do return variable

	redef meth after_typing(v)
	do
		_stype = v.variable_ctx.stype(variable)
	end
end

redef class AVarAssignExpr
	redef meth after_typing(v)
	do
		var t = v.variable_ctx.stype(variable)
		v.check_conform_expr(n_value, t)
	end
end

redef class AReassignFormExpr
	# Compute and check method used through the reassigment operator 
	private meth do_lvalue_typing(v: TypingVisitor, type_lvalue: MMType)
	do
		if type_lvalue == null then
			return
		end
		var name = n_assign_op.method_name
		var prop = type_lvalue.local_class.select_method(name)
		if prop == null then
			v.error(self, "Error: Method '{name}' doesn't exists in {type_lvalue}.")
			return
		end
		prop.global.check_visibility(v, self, v.module, false)
		var psig = prop.signature_for(type_lvalue)
		_assign_method = prop
		v.check_conform_expr(n_value, psig[0].not_for_self)
		v.check_conform(self, psig.return_type.not_for_self, n_value.stype)
	end

	# Method used through the reassigment operator (once computed)
	readable attr _assign_method: MMMethod
end

redef class AVarReassignExpr
	redef meth after_typing(v)
	do
		var t = v.variable_ctx.stype(variable)
		do_lvalue_typing(v, t)
	end
end

redef class PAssignOp
	meth method_name: Symbol is abstract
end
redef class APlusAssignOp
	redef meth method_name do return once "+".to_symbol
end
redef class AMinusAssignOp
	redef meth method_name do return once "-".to_symbol
end

redef class ASelfExpr
	redef meth its_variable do return variable

	redef meth after_typing(v)
	do
		variable = v.self_var
		_stype = v.variable_ctx.stype(variable)
	end

        redef meth is_self do return true
end

redef class AImplicitSelfExpr
        redef meth is_implicit_self do return true
end

redef class AIfexprExpr
	redef meth accept_typing(v)
	do
		var old_var_ctx = v.variable_ctx

		v.visit(n_expr)
		if n_expr.if_true_variable_ctx != null then v.variable_ctx = n_expr.if_true_variable_ctx
		v.visit(n_then)
		v.variable_ctx = old_var_ctx
		v.visit(n_else)

		v.check_conform_expr(n_expr, v.type_bool)

		if not v.check_expr(n_then) or not v.check_expr(n_else) then return

		var t = n_then.stype
		var te = n_else.stype
		if t < te then
			t = te
		else if not te < t then
			v.error(self, "Type error: {te} is not a subtype of {t}.")
			return
		end
		
		_stype = t
	end
end

redef class ABoolExpr
	redef meth after_typing(v)
	do
		_stype = v.type_bool
	end
end

redef class AOrExpr
	redef meth after_typing(v)
	do
		v.check_conform_expr(n_expr, v.type_bool)
		v.check_conform_expr(n_expr2, v.type_bool)
		_stype = v.type_bool
	end
end

redef class AAndExpr
	redef meth accept_typing(v)
	do
		var old_var_ctx = v.variable_ctx

		v.visit(n_expr)
		if n_expr.if_true_variable_ctx != null then v.variable_ctx = n_expr.if_true_variable_ctx

		v.visit(n_expr2)
		if n_expr2.if_true_variable_ctx != null then 
			_if_true_variable_ctx = n_expr2.if_true_variable_ctx
		else
			_if_true_variable_ctx = v.variable_ctx
		end

		v.variable_ctx = old_var_ctx

		v.check_conform_expr(n_expr, v.type_bool)
		v.check_conform_expr(n_expr2, v.type_bool)
		_stype = v.type_bool
	end
end

redef class ANotExpr
	redef meth after_typing(v)
	do
		v.check_conform_expr(n_expr, v.type_bool)
		_stype = v.type_bool
	end
end

redef class AIntExpr
	redef meth after_typing(v)
	do
		_stype = v.type_int

	end
end

redef class AFloatExpr
	redef meth after_typing(v)
	do
		_stype = v.type_float
	end
end

redef class ACharExpr
	redef meth after_typing(v)
	do
		_stype = v.type_char
	end
end

redef class AStringFormExpr
	readable attr _meth_with_native: MMMethod
	redef meth after_typing(v)
	do
		_stype = v.type_string
		_meth_with_native = _stype.local_class.select_method(once "with_native".to_symbol)
		if _meth_with_native == null then v.error(self, "{_stype} MUST have a with_native method.")
	end
end

redef class ASuperstringExpr
	readable attr _meth_with_capacity: MMMethod
	readable attr _meth_add: MMMethod
	readable attr _meth_to_s: MMMethod
	readable attr _atype: MMType
	redef meth after_typing(v)
	do
		_stype = v.type_string
		_atype = v.type_array(_stype)
		_meth_with_capacity = _atype.local_class.select_method(once "with_capacity".to_symbol)
		if _meth_with_capacity == null then v.error(self, "{_atype} MUST have a with_capacity method.")
		_meth_add = _atype.local_class.select_method(once "add".to_symbol)
		if _meth_add == null then v.error(self, "{_atype} MUST have an add method.")
		_meth_to_s = v.type_object.local_class.select_method(once "to_s".to_symbol)
		if _meth_to_s == null then v.error(self, "Object MUST have a to_s method.")
	end
end

redef class ANullExpr
	redef meth after_typing(v)
	do
		_stype = v.type_none
	end
end

redef class AArrayExpr
	readable attr _meth_with_capacity: MMMethod
	readable attr _meth_add: MMMethod

	redef meth after_typing(v)
	do
		var stype: MMType = null
		for n in n_exprs do
			var ntype = n.stype
			if stype == null or (ntype != null and stype < ntype) then
				stype = ntype
			end
		end
		for n in n_exprs do
			v.check_conform_expr(n, stype)
		end
		do_typing(v, stype)
	end

	private meth do_typing(v: TypingVisitor, element_type: MMType)
	do
		_stype = v.type_array(element_type)

		_meth_with_capacity = _stype.local_class.select_method(once "with_capacity".to_symbol)
		if _meth_with_capacity == null then v.error(self, "{_stype} MUST have a with_capacity method.")
		_meth_add = _stype.local_class.select_method(once "add".to_symbol)
		if _meth_add == null then v.error(self, "{_stype} MUST have an add method.")
	end
end

redef class ARangeExpr
	readable attr _meth_init: MMMethod
	redef meth after_typing(v)
	do
		var ntype = n_expr.stype
		var ntype2 = n_expr2.stype
		if ntype == null or ntype == null then
			return
		end
		if ntype < ntype2 then
			ntype = ntype2
		else if not ntype2 < ntype then
			v.error(self, "Type error: {ntype} incompatible with {ntype2}.")
			return
		end
		var dtype = v.type_discrete
		v.check_conform_expr(n_expr, dtype)
		v.check_conform_expr(n_expr2, dtype)
		_stype = v.type_range(ntype)
	end
end

redef class ACrangeExpr
	redef meth after_typing(v)
	do
		super
		_meth_init = stype.local_class.select_method(once "init".to_symbol)
	end
end
redef class AOrangeExpr
	redef meth after_typing(v)
	do
		super
		_meth_init = stype.local_class.select_method(once "without_last".to_symbol)
	end
end


redef class ASuperExpr
special ASuperInitCall
	# readable attr _prop: MMSrcMethod
	readable attr _init_in_superclass: MMMethod
	redef meth after_typing(v)
	do
		var precs: Array[MMLocalProperty] = v.local_property.prhe.direct_greaters
		if not precs.is_empty then
			v.local_property.need_super = true
		else if v.local_property.global.is_init then
			var base_precs = v.local_class.super_methods_named(v.local_property.name)
			for p in base_precs do
				if not p.global.is_init then
					v.error(self, "Error: {p.local_class}::{p} is not a constructor.")
				else
					precs.add(v.local_class[p.global])
				end
			end
			if precs.is_empty then
				v.error(self, "Error: No contructor named {v.local_property.name} in superclasses.")
				return
			else if precs.length > 1 then
				v.error(self, "Error: Conflicting contructors named {v.local_property.name} in superclasses: {precs.join(", ")}.")
				return
			end
			var p = base_precs.first
			assert p isa MMMethod
			_init_in_superclass = p
			register_super_init_call(v, p)
			if n_args.length > 0 then
				var signature = get_signature(v, v.self_var.stype, p, true)
				_arguments = process_signature(v, signature, p.name, n_args.to_a)
			end
		else
			v.error(self, "Error: No super method to call for {v.local_property}.")
			return
		end

		if precs.first.signature_for(v.self_var.stype).return_type != null then
			var stypes = new Array[MMType]
			var stype: MMType = null
			for prop in precs do
				assert prop isa MMMethod
				var t = prop.signature_for(v.self_var.stype).return_type.for_module(v.module).adapt_to(v.local_property.signature.recv)
				stypes.add(t)
				if stype == null or stype < t then
					stype = t
				end
			end
			for t in stypes do
				v.check_conform(self, t, stype)
			end
			_stype = stype
		end
		var p = v.local_property
		assert p isa MMSrcMethod
		_prop = p
	end
end

redef class AAttrFormExpr
	# Attribute accessed
	readable attr _prop: MMAttribute

	# Attribute type of the acceded attribute
	readable attr _attr_type: MMType

	# Compute the attribute accessed
	private meth do_typing(v: TypingVisitor)
	do
		if not v.check_expr(n_expr) then return
		var type_recv = n_expr.stype
		var name = n_id.to_symbol
		var prop = type_recv.local_class.select_attribute(name)
		if prop == null then
			v.error(self, "Error: Attribute {name} doesn't exists in {type_recv}.")
			return
		else if v.module.visibility_for(prop.global.local_class.module) < 3 then
			v.error(self, "Error: Attribute {name} from {prop.global.local_class.module} is invisible in {v.module}")
		end
		_prop = prop
		var at = prop.signature_for(type_recv).return_type 
		if not n_expr.is_self then at = at.not_for_self
		_attr_type = at
	end
end

redef class AAttrExpr
	redef meth after_typing(v)
	do
		do_typing(v)
		if prop == null then
			return
		end
		_stype = attr_type
	end
end

redef class AAttrAssignExpr
	redef meth after_typing(v)
	do
		do_typing(v)
		if prop == null then
			return
		end
		v.check_conform_expr(n_value, attr_type)
	end
end

redef class AAttrReassignExpr
	redef meth after_typing(v)
	do
		do_typing(v)
		if prop == null then
			return
		end
		do_lvalue_typing(v, attr_type)
	end
end

class AAbsSendExpr
special PExpr
	# The signature of the called property
	readable attr _prop_signature: MMSignature

	# Compute the called global property
	private meth do_typing(v: TypingVisitor, type_recv: MMType, is_implicit_self: Bool, recv_is_self: Bool, name: Symbol, raw_args: Array[PExpr], closure_defs: Array[PClosureDef])
	do
		var prop = get_property(v, type_recv, is_implicit_self, name)
		if prop == null then return
		var sig = get_signature(v, type_recv, prop, recv_is_self)
		if sig == null then return
		var args = process_signature(v, sig, prop.name, raw_args)
		if args == null then return
		var rtype = process_closures(v, sig, prop.name, closure_defs)
		_prop = prop
		_prop_signature = sig
		_arguments = args
		_return_type = rtype
	end

	private meth get_property(v: TypingVisitor, type_recv: MMType, is_implicit_self: Bool, name: Symbol): MMMethod
	do
		if type_recv == null then return null
		var prop = type_recv.local_class.select_method(name)
		if prop == null and v.local_property.global.is_init then
			var props = type_recv.local_class.super_methods_named(name)
			if props.length > 1 then
				v.error(self, "Error: Ambigous method name '{name}' for {props.join(", ")}. Use explicit designation.")
				return null
			else if props.length == 1 then 
				var p = type_recv.local_class[props.first.global]
				assert p isa MMMethod
				prop = p
			end

		end
		if prop == null then
			if is_implicit_self then
				v.error(self, "Error: Method or variable '{name}' unknown in {type_recv}.")
			else
				v.error(self, "Error: Method '{name}' doesn't exists in {type_recv}.")
			end
			return null
		end
		return prop
	end

	# Get the signature for a local property and a receiver
	private meth get_signature(v: TypingVisitor, type_recv: MMType, prop: MMMethod, recv_is_self: Bool): MMSignature
	do
		prop.global.check_visibility(v, self, v.module, recv_is_self)
		var psig = prop.signature_for(type_recv)
		if not recv_is_self then psig = psig.not_for_self
		return psig
	end

	# Check the conformity of a set of arguments `raw_args' to a signature.
	private meth process_signature(v: TypingVisitor, psig: MMSignature, name: Symbol, raw_args: Array[PExpr]): Array[PExpr]
	do
		var par_vararg = psig.vararg_rank
		var par_arity = psig.arity
		var raw_arity: Int
		if raw_args == null then raw_arity = 0 else raw_arity = raw_args.length
		if par_arity > raw_arity or (par_arity != raw_arity and par_vararg == -1) then
			v.error(self, "Error: '{name}' arity missmatch.")
			return null
		end
		var arg_idx = 0
		var args = new Array[PExpr]
		for par_idx in [0..par_arity[ do
			var a: PExpr
			var par_type = psig[par_idx]
			if par_idx == par_vararg then
				var star = new Array[PExpr]
				for i in [0..(raw_arity-par_arity)] do
					a = raw_args[arg_idx]
					v.check_conform_expr(a, par_type)
					star.add(a)
					arg_idx = arg_idx + 1
				end
				var aa = new AArrayExpr.init_aarrayexpr(star)
				aa.do_typing(v, par_type)
				a = aa
			else
				a = raw_args[arg_idx]
				v.check_conform_expr(a, par_type)
				arg_idx = arg_idx + 1
			end
			args.add(a)
		end
		return args
	end

	# Check the conformity of a set of defined closures
	private meth process_closures(v: TypingVisitor, psig: MMSignature, name: Symbol, cd: Array[PClosureDef]): MMType
	do
		var t = psig.return_type
		var cs = psig.closures # Declared closures
		var min_arity = 0
		for c in cs do
			if not c.is_optional then min_arity += 1
		end
		if cd != null then
			if cs.length == 0 then
				v.error(self, "Error: {name} does not require blocs.")
			else if cd.length > cs.length or cd.length < min_arity then
				v.error(self, "Error: {name} requires {cs.length} blocs, {cd.length} found.")
			else
				var old_bbst = v.closure_break_stype
				var old_bl = v.break_list
				v.closure_break_stype = t
				v.break_list = new Array[ABreakExpr]
				for i in [0..cd.length[ do
					cd[i].accept_typing2(v, cs[i])
				end
				for n in v.break_list do
					var ntype = n.stype
					if t == null or (t != null and t < ntype) then
						t = ntype
					end
				end
				for n in v.break_list do
					v.check_conform_expr(n, t)
				end

				v.closure_break_stype = old_bbst
				v.break_list = old_bl
			end
		else if min_arity != 0 then
			v.error(self, "Error: {name} requires {cs.length} blocs.")
		end
		return t
	end

	# The invoked method (once computed)
	readable attr _prop: MMMethod

	# The real arguments used (after star transformation) (once computed)
	readable attr _arguments: Array[PExpr]

	# The return type (if any) (once computed)
	readable attr _return_type: MMType
end

# A possible call of constructor in a super class
# Could be an explicit call or with the 'super' keyword
class ASuperInitCall
special AAbsSendExpr
	private meth register_super_init_call(v: TypingVisitor, property: MMMethod)
	do
		if parent != v.top_block and self != v.top_block then
			v.error(self, "Error: Constructor invocation {property} must not be in nested block.")
		end
		var cla = v.module[property.global.intro.local_class.global]
		var prev_class: MMLocalClass = null
		if not v.explicit_super_init_calls.is_empty then
			prev_class = v.explicit_super_init_calls.last.global.intro.local_class
		end
		var order = v.local_class.cshe.reverse_linear_extension
		if cla == v.local_class then
			v.explicit_other_init_call = true
		else if not order.has(cla) then
			v.error(self, "Error: Constructor of class {cla} must be one in {order.join(", ")}.")
		else if cla == prev_class then
			v.error(self, "Error: Only one super constructor invocation of class {cla} is allowed.")
		else
			var last_is_found = prev_class == null
			for c in order do
				if c == prev_class then
					last_is_found = true
				else if c == cla then
					if not last_is_found then
						v.error(self, "Error: Constructor of {c} must be invoked before constructor of {prev_class}")
					end
					v.explicit_super_init_calls.add(property)
					break
				end
			end
		end
	end

end

redef class ANewExpr
special AAbsSendExpr
	redef meth after_typing(v)
	do
		var t = n_type.stype
		if t == null then return
		if t.local_class.global.is_abstract then
			v.error(self, "Error: try to instantiate abstract class {t.local_class}.")
			return
		end
		var name: Symbol
		if n_id == null then
			name = once "init".to_symbol
		else
			name = n_id.to_symbol
		end

		do_typing(v, t, false, false, name, n_args.to_a, null)
		if prop == null then return

		if not prop.global.is_init then
			v.error(self, "Error: {prop} is not a constructor.")
		end
		_stype = t
	end
end


redef class ASendExpr
special ASuperInitCall
	# Name of the invoked property
	meth name: Symbol is abstract 

	# Raw arguments used (withour star transformation)
	meth raw_arguments: Array[PExpr] is abstract

	# Closure definitions
	meth closure_defs: Array[PClosureDef] do return null

	redef meth after_typing(v)
	do
		do_all_typing(v)
	end

	private meth do_all_typing(v: TypingVisitor)
	do
		if not v.check_expr(n_expr) then return
		do_typing(v, n_expr.stype, n_expr.is_implicit_self, n_expr.is_self, name, raw_arguments, closure_defs)
		if prop == null then return

		if prop.global.is_init then
			if not v.local_property.global.is_init then
				v.error(self, "Error: try to invoke constructor {prop} in a method.")
			else if not n_expr.is_self then
				v.error(self, "Error: constructor {prop} is not invoken on 'self'.")
			else
				register_super_init_call(v, prop)
			end
		end

		_stype = return_type
	end
end

class ASendReassignExpr
special ASendExpr
special AReassignFormExpr
	readable attr _read_prop: MMMethod
	redef meth do_all_typing(v)
	do
		if not v.check_expr(n_expr) then return
		var raw_args = raw_arguments
		do_typing(v, n_expr.stype, n_expr.is_implicit_self, n_expr.is_self, name, raw_args, null)
		if prop == null then return
		if prop.global.is_init then
			if not v.local_property.global.is_init then
				v.error(self, "Error: try to invoke constructor {prop} in a method.")
			else if not n_expr.is_self then
				v.error(self, "Error: constructor {prop} is not invoken on 'self'.")
			end
		end
		var t = prop.signature_for(n_expr.stype).return_type
		if not n_expr.is_self then t = t.not_for_self

		do_lvalue_typing(v, t)

		_read_prop = prop
		var old_args = arguments
		raw_args.add(n_value)

		do_typing(v, n_expr.stype, n_expr.is_implicit_self, n_expr.is_self, "{name}=".to_symbol, raw_args, null)
		if prop == null then return
		if prop.global.is_init then
			if not v.local_property.global.is_init then
				v.error(self, "Error: try to invoke constructor {prop} in a method.")
			else if not n_expr.is_self then
				v.error(self, "Error: constructor {prop} is not invoken on 'self'.")
			end
		end

		_arguments = old_args # FIXME: What if star parameters do not match betwen the two methods?
	end
end

redef class ABinopExpr
	redef meth raw_arguments do return [n_expr2]
end
redef class AEqExpr
	redef meth name do return once "==".to_symbol
end
redef class ANeExpr
	redef meth name do return once "!=".to_symbol
end
redef class ALtExpr
	redef meth name do return once "<".to_symbol
end
redef class ALeExpr
	redef meth name do return once "<=".to_symbol
end
redef class AGtExpr
	redef meth name do return once ">".to_symbol
end
redef class AGeExpr
	redef meth name do return once ">=".to_symbol
end
redef class APlusExpr
	redef meth name do return once "+".to_symbol
end
redef class AMinusExpr
	redef meth name do return once "-".to_symbol
end
redef class AStarshipExpr
	redef meth name do return once "<=>".to_symbol
end
redef class AStarExpr
	redef meth name do return once "*".to_symbol
end
redef class ASlashExpr
	redef meth name do return once "/".to_symbol
end
redef class APercentExpr
	redef meth name do return once "%".to_symbol
end

redef class AUminusExpr
	redef meth name do return once "unary -".to_symbol
	redef meth raw_arguments do return null
end

redef class ACallFormExpr
	redef meth after_typing(v)
	do
		if n_expr != null and n_expr.is_implicit_self then
			var name = n_id.to_symbol
			var variable = v.variable_ctx[name]
			if variable != null then
				if variable isa ClosureVariable then
					var n = new AClosureCallExpr(n_id, n_args, n_closure_defs)
					replace_with(n)
					n.variable = variable
					n.after_typing(v)
					return
				else
					if not n_args.is_empty then
						v.error(self, "Error: {name} is variable, not a function.")
					end
					var vform = variable_create(variable)
					vform.variable = variable
					replace_with(vform)
					vform.after_typing(v)
					return
				end
			end
		end
		super
	end
	
	redef meth closure_defs
	do
		if n_closure_defs == null or n_closure_defs.is_empty then
			return null
		else
			return n_closure_defs.to_a
		end
	end

	# Create a variable acces corresponding to the call form
	meth variable_create(variable: Variable): AVarFormExpr is abstract
end

redef class ACallExpr
	redef meth variable_create(variable)
	do
		return new AVarExpr.init_avarexpr(n_id)
	end

	redef meth name do return n_id.to_symbol
	redef meth raw_arguments do return n_args.to_a
end

redef class ACallAssignExpr
	redef meth variable_create(variable)
	do
		return new AVarAssignExpr.init_avarassignexpr(n_id, n_assign, n_value)
	end

	redef meth name do return (n_id.text + "=").to_symbol
	redef meth raw_arguments do
		var res = n_args.to_a
		res.add(n_value)
		return res
	end
end

redef class ACallReassignExpr
special ASendReassignExpr
	redef meth variable_create(variable)
	do
		return new AVarReassignExpr.init_avarreassignexpr(n_id, n_assign_op, n_value)
	end

	redef meth name do return n_id.to_symbol
	redef meth raw_arguments do return n_args.to_a
end

redef class ABraExpr
	redef meth name do return once "[]".to_symbol
	redef meth raw_arguments do return n_args.to_a
end

redef class ABraAssignExpr
	redef meth name do return once "[]=".to_symbol
	redef meth raw_arguments do
		var res = n_args.to_a
		res.add(n_value)
		return res
	end
end

redef class ABraReassignExpr
special ASendReassignExpr
	redef meth name do return once "[]".to_symbol
	redef meth raw_arguments do return n_args.to_a
end

redef class AInitExpr
	redef meth name do return once "init".to_symbol
	redef meth raw_arguments do return n_args.to_a
end

redef class AClosureCallExpr
	redef meth after_typing(v)
	do
		var va = variable
		var sig = va.closure.signature
		var args = process_signature(v, sig, n_id.to_symbol, n_args.to_a)
		if closure_defs != null then
			process_closures(v, sig, n_id.to_symbol, closure_defs)
		end
		if args == null then return
		_prop = null
		_prop_signature = sig
		_arguments = args
		_stype = sig.return_type
	end
end

redef class PClosureDef
	attr _accept_typing2: Bool
	redef meth accept_typing(v)
	do
		# Typing is deferred, wait accept_typing2(v)
		if _accept_typing2 then super
	end

	private meth accept_typing2(v: TypingVisitor, clos: MMClosure) is abstract
end

redef class AClosureDef
	redef meth accept_typing2(v, clos)
	do	
		var sig = clos.signature
		if sig.arity != n_id.length then
			v.error(self, "Error: {sig.arity} automatic variable names expected, {n_id.length} found.")
			return
		end

		closure = clos

		var old_clos = v.closure
		v.closure = clos

		v.variable_ctx = v.variable_ctx.sub
		variables = new Array[AutoVariable]
		for i in [0..n_id.length[ do
			var va = new AutoVariable(n_id[i].to_symbol, self)
			variables.add(va)
			va.stype = sig[i]
			v.variable_ctx.add(va)
		end

		_accept_typing2 = true
		accept_typing(v)

		v.closure = old_clos
	end
end

redef class AIsaExpr
	redef meth after_typing(v)
	do
		var variable = n_expr.its_variable
		if variable != null then
			_if_true_variable_ctx = v.variable_ctx.sub_with(variable, n_type.stype)
		end
		_stype = v.type_bool
	end
end

redef class AAsCastExpr
	redef meth after_typing(v)
	do
		v.check_expr(n_expr)
		_stype = n_type.stype
	end
end

redef class AProxyExpr
	redef meth after_typing(v)
	do
		_stype = n_expr.stype
	end
end
