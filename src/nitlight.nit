# This file is part of NIT ( http://www.nitlanguage.org ).
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

# Tool that produces highlighting for Nit programs
module nitlight

import highlight

var toolcontext = new ToolContext

var opt_fragment = new OptionBool("Omit document header and footer", "-f", "--fragment")
var opt_dir = new OptionString("Output html files in a specific directory (required if more than one module)", "-d", "--dir")
var opt_full = new OptionBool("Process also imported modules", "--full")
var opt_ast = new OptionBool("Generate specific HTML elements for each Node of the AST", "--ast")
toolcontext.option_context.add_option(opt_fragment, opt_dir, opt_full)

var model = new Model
var modelbuilder = new ModelBuilder(model, toolcontext)

toolcontext.process_options
var args = toolcontext.option_context.rest

if args.is_empty then
	print "usage: nitlight [options] files..."
	toolcontext.option_context.usage
	return
end

var mmodules = modelbuilder.parse(args)
modelbuilder.run_phases

if opt_full.value then mmodules = model.mmodules

var dir = opt_dir.value
if dir != null then
	dir.mkdir
else if mmodules.length > 1 then
	print "More than one module to render, use option -d"
	return
end

for mm in mmodules do
	if dir != null then toolcontext.info("write {dir}/{mm.name}.html", 1)

	var v = new HighlightVisitor
	if opt_ast.value then v.with_ast = true
	var page = null
	if not opt_fragment.value then
		page = new HTMLTag("html")
		page.add_raw_html """<head>
		<meta charset="utf-8">"""
		if dir == null then
			page.add_raw_html """
			<style type="text/css">
			{{{v.css_content}}}
			</style>
			"""
		else
			page.add_raw_html """<link rel="stylesheet" type="text/css" href="style.css" />"""
		end
		page.add_raw_html "</head><body><pre>"
	end
	var m = modelbuilder.mmodule2nmodule[mm]
	v.enter_visit(m)
	if not opt_fragment.value then
		page.add(v.html)
		page.add_raw_html "</pre></body>"
	else
		page = v.html
	end

	if dir != null then
		page.save("{dir}/{mm.name}.html")
	else
		print page.html
	end
end

if dir != null then
	toolcontext.info("write {dir}/index.html", 1)

	var page = new HTMLTag("html")
	page.add_raw_html """<head>
	<meta charset="utf-8">
	</head><body><ul>
	"""
	for mm in mmodules do
		var n = new HTMLTag("li")
		var n2 = new HTMLTag("a")
		page.add n
		n.add n2
		n2.attr("href", "{mm.name}.html")
		n2.text(mm.name)
	end
	page.add_raw_html "</li></body>"
	page.save("{dir}/index.html")

	var v = new HighlightVisitor
	toolcontext.info("write {dir}/style.css", 1)
	var f = new OFStream.open("{dir}/style.css")
	f.write v.css_content
	f.close
end
