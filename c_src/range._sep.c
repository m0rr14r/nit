/* This C file is generated by NIT to compile module range. */
#include "range._sep.h"
val_t range___Range___first(val_t  self) {
  struct trace_t trace = {NULL, NULL, 22, LOCATE_range___Range___first};
  trace.prev = tracehead; tracehead = &trace;
  trace.file = LOCATE_range;
  tracehead = trace.prev;
  return ATTR_range___Range____first( self) /*Range::_first*/;
}
val_t range___Range___last(val_t  self) {
  struct trace_t trace = {NULL, NULL, 24, LOCATE_range___Range___last};
  trace.prev = tracehead; tracehead = &trace;
  trace.file = LOCATE_range;
  tracehead = trace.prev;
  return ATTR_range___Range____last( self) /*Range::_last*/;
}
val_t range___Range___after(val_t  self) {
  struct trace_t trace = {NULL, NULL, 27, LOCATE_range___Range___after};
  trace.prev = tracehead; tracehead = &trace;
  trace.file = LOCATE_range;
  tracehead = trace.prev;
  return ATTR_range___Range____after( self) /*Range::_after*/;
}
val_t range___Range___has(val_t  self, val_t  param0) {
  struct trace_t trace = {NULL, NULL, 30, LOCATE_range___Range___has};
  val_t variable0;
  val_t variable1;
  val_t variable2;
  trace.prev = tracehead; tracehead = &trace;
  trace.file = LOCATE_range;
  variable0 =  param0;
  variable1 = ATTR_range___Range____first( self) /*Range::_first*/;
  variable1 = ((kernel___Comparable_____geq_t)CALL( variable0 /*item*/,COLOR_kernel___Comparable_____geq))( variable0 /*item*/, variable1) /*Comparable::>=*/;
  variable2 = variable1;
  if (UNTAG_Bool(variable2)) { /* and */
    variable2 = ATTR_range___Range____last( self) /*Range::_last*/;
    variable2 = ((kernel___Comparable_____leq_t)CALL( variable0 /*item*/,COLOR_kernel___Comparable_____leq))( variable0 /*item*/, variable2) /*Comparable::<=*/;
  }
  variable1 = variable2;
  goto return_label0;
  return_label0: while(false);
  tracehead = trace.prev;
  return variable1;
}
val_t range___Range___has_only(val_t  self, val_t  param0) {
  struct trace_t trace = {NULL, NULL, 32, LOCATE_range___Range___has_only};
  val_t variable0;
  val_t variable1;
  val_t variable2;
  trace.prev = tracehead; tracehead = &trace;
  trace.file = LOCATE_range;
  variable0 =  param0;
  variable1 = ATTR_range___Range____first( self) /*Range::_first*/;
  variable1 = TAG_Bool((variable1 ==  variable0 /*item*/) || ((variable1 != NIT_NULL) && ((((kernel___Object_____eqeq_t)CALL(variable1,COLOR_kernel___Object_____eqeq))==kernel___Object_____eqeq)?(IS_EQUAL_NN(variable1, variable0 /*item*/)):(UNTAG_Bool(((kernel___Object_____eqeq_t)CALL(variable1,COLOR_kernel___Object_____eqeq))(variable1,  variable0 /*item*/) /*Object::==*/)))));
  variable2 = variable1;
  if (UNTAG_Bool(variable2)) { /* and */
    variable2 = ATTR_range___Range____last( self) /*Range::_last*/;
    variable2 = TAG_Bool(( variable0 /*item*/ == variable2) || (( variable0 /*item*/ != NIT_NULL) && ((((kernel___Object_____eqeq_t)CALL( variable0 /*item*/,COLOR_kernel___Object_____eqeq))==kernel___Object_____eqeq)?(IS_EQUAL_NN( variable0 /*item*/,variable2)):(UNTAG_Bool(((kernel___Object_____eqeq_t)CALL( variable0 /*item*/,COLOR_kernel___Object_____eqeq))( variable0 /*item*/, variable2) /*Object::==*/)))));
  }
  variable1 = variable2;
  goto return_label1;
  return_label1: while(false);
  tracehead = trace.prev;
  return variable1;
}
val_t range___Range___count(val_t  self, val_t  param0) {
  struct trace_t trace = {NULL, NULL, 34, LOCATE_range___Range___count};
  val_t variable0;
  val_t variable1;
  trace.prev = tracehead; tracehead = &trace;
  trace.file = LOCATE_range;
  variable0 =  param0;
  variable1 = ((range___Range___has_t)CALL( self,COLOR_abstract_collection___Collection___has))( self,  variable0 /*item*/) /*Range::has*/;
  if (UNTAG_Bool(variable1)) { /*if*/
    variable1 =  TAG_Int(1);
    goto return_label2;
  } else { /*if*/
    variable1 =  TAG_Int(0);
    goto return_label2;
  }
  return_label2: while(false);
  tracehead = trace.prev;
  return variable1;
}
val_t range___Range___iterator(val_t  self) {
  struct trace_t trace = {NULL, NULL, 43, LOCATE_range___Range___iterator};
  val_t variable0;
  trace.prev = tracehead; tracehead = &trace;
  trace.file = LOCATE_range;
  variable0 = NEW_IteratorRange_range___IteratorRange___init( self); /*new IteratorRange[E]*/
  goto return_label3;
  return_label3: while(false);
  tracehead = trace.prev;
  return variable0;
}
val_t range___Range___length(val_t  self) {
  struct trace_t trace = {NULL, NULL, 45, LOCATE_range___Range___length};
  val_t variable0;
  val_t variable1;
  val_t variable2;
  trace.prev = tracehead; tracehead = &trace;
  trace.file = LOCATE_range;
  variable1 = ATTR_range___Range____first( self) /*Range::_first*/;
  variable2 = ATTR_range___Range____after( self) /*Range::_after*/;
  variable1 = ((kernel___Discrete___distance_t)CALL(variable1,COLOR_kernel___Discrete___distance))(variable1, variable2) /*Discrete::distance*/;
  variable0 = variable1;
  variable1 = TAG_Bool(UNTAG_Int( variable0 /*nb*/)>UNTAG_Int( TAG_Int(0)));
  if (UNTAG_Bool(variable1)) { /*if*/
    variable0 =  variable0 /*nb*/;
    goto return_label4;
  } else { /*if*/
    variable0 =  TAG_Int(0);
    goto return_label4;
  }
  return_label4: while(false);
  tracehead = trace.prev;
  return variable0;
}
val_t range___Range___is_empty(val_t  self) {
  struct trace_t trace = {NULL, NULL, 55, LOCATE_range___Range___is_empty};
  val_t variable0;
  val_t variable1;
  trace.prev = tracehead; tracehead = &trace;
  trace.file = LOCATE_range;
  variable0 = ATTR_range___Range____first( self) /*Range::_first*/;
  variable1 = ATTR_range___Range____after( self) /*Range::_after*/;
  variable0 = ((kernel___Comparable_____geq_t)CALL(variable0,COLOR_kernel___Comparable_____geq))(variable0, variable1) /*Comparable::>=*/;
  goto return_label5;
  return_label5: while(false);
  tracehead = trace.prev;
  return variable0;
}
void range___Range___init(val_t  self, val_t  param0, val_t  param1, int* init_table) {
  struct trace_t trace = {NULL, NULL, 57, LOCATE_range___Range___init};
  val_t variable0;
  val_t variable1;
  val_t variable2;
  trace.prev = tracehead; tracehead = &trace;
  trace.file = LOCATE_range;
  variable0 =  param0;
  variable1 =  param1;
  if (init_table[VAL2OBJ( self)->vft[INIT_TABLE_POS_Range].i]) return;
  ATTR_range___Range____first( self) /*Range::_first*/ =  variable0 /*from*/;
  ATTR_range___Range____last( self) /*Range::_last*/ =  variable1 /*to*/;
  variable2 = ((kernel___Discrete___succ_t)CALL( variable1 /*to*/,COLOR_kernel___Discrete___succ))( variable1 /*to*/) /*Discrete::succ*/;
  ATTR_range___Range____after( self) /*Range::_after*/ = variable2;
  init_table[VAL2OBJ( self)->vft[INIT_TABLE_POS_Range].i] = 1;
  tracehead = trace.prev;
  return;
}
void range___Range___without_last(val_t  self, val_t  param0, val_t  param1, int* init_table) {
  struct trace_t trace = {NULL, NULL, 66, LOCATE_range___Range___without_last};
  val_t variable0;
  val_t variable1;
  val_t variable2;
  trace.prev = tracehead; tracehead = &trace;
  trace.file = LOCATE_range;
  variable0 =  param0;
  variable1 =  param1;
  if (init_table[VAL2OBJ( self)->vft[INIT_TABLE_POS_Range].i]) return;
  ATTR_range___Range____first( self) /*Range::_first*/ =  variable0 /*from*/;
  variable2 = ((kernel___Discrete___prec_t)CALL( variable1 /*to*/,COLOR_kernel___Discrete___prec))( variable1 /*to*/) /*Discrete::prec*/;
  ATTR_range___Range____last( self) /*Range::_last*/ = variable2;
  ATTR_range___Range____after( self) /*Range::_after*/ =  variable1 /*to*/;
  init_table[VAL2OBJ( self)->vft[INIT_TABLE_POS_Range].i] = 1;
  tracehead = trace.prev;
  return;
}
val_t range___IteratorRange___item(val_t  self) {
  struct trace_t trace = {NULL, NULL, 80, LOCATE_range___IteratorRange___item};
  trace.prev = tracehead; tracehead = &trace;
  trace.file = LOCATE_range;
  tracehead = trace.prev;
  return ATTR_range___IteratorRange____item( self) /*IteratorRange::_item*/;
}
val_t range___IteratorRange___is_ok(val_t  self) {
  struct trace_t trace = {NULL, NULL, 82, LOCATE_range___IteratorRange___is_ok};
  val_t variable0;
  val_t variable1;
  trace.prev = tracehead; tracehead = &trace;
  trace.file = LOCATE_range;
  variable0 = ATTR_range___IteratorRange____item( self) /*IteratorRange::_item*/;
  variable1 = ATTR_range___IteratorRange____range( self) /*IteratorRange::_range*/;
  variable1 = ((range___Range___after_t)CALL(variable1,COLOR_range___Range___after))(variable1) /*Range::after*/;
  variable0 = ((kernel___Comparable_____l_t)CALL(variable0,COLOR_kernel___Comparable_____l))(variable0, variable1) /*Comparable::<*/;
  goto return_label8;
  return_label8: while(false);
  tracehead = trace.prev;
  return variable0;
}
void range___IteratorRange___next(val_t  self) {
  struct trace_t trace = {NULL, NULL, 84, LOCATE_range___IteratorRange___next};
  val_t variable0;
  trace.prev = tracehead; tracehead = &trace;
  trace.file = LOCATE_range;
  variable0 = ATTR_range___IteratorRange____item( self) /*IteratorRange::_item*/;
  variable0 = ((kernel___Discrete___succ_t)CALL(variable0,COLOR_kernel___Discrete___succ))(variable0) /*Discrete::succ*/;
  ATTR_range___IteratorRange____item( self) /*IteratorRange::_item*/ = variable0;
  tracehead = trace.prev;
  return;
}
void range___IteratorRange___init(val_t  self, val_t  param0, int* init_table) {
  struct trace_t trace = {NULL, NULL, 86, LOCATE_range___IteratorRange___init};
  val_t variable0;
  val_t variable1;
  trace.prev = tracehead; tracehead = &trace;
  trace.file = LOCATE_range;
  variable0 =  param0;
  if (init_table[VAL2OBJ( self)->vft[INIT_TABLE_POS_IteratorRange].i]) return;
  ATTR_range___IteratorRange____range( self) /*IteratorRange::_range*/ =  variable0 /*r*/;
  variable1 = ((range___Range___first_t)CALL( variable0 /*r*/,COLOR_abstract_collection___Collection___first))( variable0 /*r*/) /*Range::first*/;
  ATTR_range___IteratorRange____item( self) /*IteratorRange::_item*/ = variable1;
  init_table[VAL2OBJ( self)->vft[INIT_TABLE_POS_IteratorRange].i] = 1;
  tracehead = trace.prev;
  return;
}
