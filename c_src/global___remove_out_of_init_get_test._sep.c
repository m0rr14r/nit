/* This C file is generated by NIT to compile module global___remove_out_of_init_get_test. */
#include "global___remove_out_of_init_get_test._sep.h"
static const char LOCATE_global___remove_out_of_init_get_test___Program___nb_optimized_isset[] = "remove_out_of_init_get_test::Program::nb_optimized_isset";
val_t global___remove_out_of_init_get_test___Program___nb_optimized_isset(val_t p0){
  struct {struct stack_frame_t me;} fra;
  val_t REGB0;
  val_t tmp;
  fra.me.prev = stack_frame_head; stack_frame_head = &fra.me;
  fra.me.file = LOCATE_global___remove_out_of_init_get_test;
  fra.me.line = 24;
  fra.me.meth = LOCATE_global___remove_out_of_init_get_test___Program___nb_optimized_isset;
  fra.me.has_broke = 0;
  fra.me.REG_size = 1;
  fra.me.nitni_local_ref_head = NULL;
  fra.me.REG[0] = NIT_NULL;
  fra.me.REG[0] = p0;
  /* global/remove_out_of_init_get_test.nit:24 */
  REGB0 = TAG_Bool(ATTR_global___remove_out_of_init_get_test___Program____nb_optimized_isset(fra.me.REG[0])!=NIT_NULL);
  if (UNTAG_Bool(REGB0)) {
  } else {
    nit_abort("Uninitialized attribute %s", "_nb_optimized_isset", LOCATE_global___remove_out_of_init_get_test, 24);
  }
  REGB0 = ATTR_global___remove_out_of_init_get_test___Program____nb_optimized_isset(fra.me.REG[0]);
  stack_frame_head = fra.me.prev;
  return REGB0;
}
static const char LOCATE_global___remove_out_of_init_get_test___Program___optimize_out_of_init_getters[] = "remove_out_of_init_get_test::Program::optimize_out_of_init_getters";
void global___remove_out_of_init_get_test___Program___optimize_out_of_init_getters(val_t p0){
  struct {struct stack_frame_t me;} fra;
  val_t tmp;
  fra.me.prev = stack_frame_head; stack_frame_head = &fra.me;
  fra.me.file = LOCATE_global___remove_out_of_init_get_test;
  fra.me.line = 26;
  fra.me.meth = LOCATE_global___remove_out_of_init_get_test___Program___optimize_out_of_init_getters;
  fra.me.has_broke = 0;
  fra.me.REG_size = 1;
  fra.me.nitni_local_ref_head = NULL;
  fra.me.REG[0] = NIT_NULL;
  fra.me.REG[0] = p0;
  CALL_program___Program___with_each_iroutines(fra.me.REG[0])(fra.me.REG[0], (&(fra.me)), ((fun_t)OC_global___remove_out_of_init_get_test___Program___optimize_out_of_init_getters_1));
  stack_frame_head = fra.me.prev;
  return;
}
  void OC_global___remove_out_of_init_get_test___Program___optimize_out_of_init_getters_1(struct stack_frame_t *closctx, val_t p0, val_t p1){
    struct {struct stack_frame_t me; val_t MORE_REG[1];} fra;
    val_t REGB0;
    val_t REGB1;
    val_t tmp;
    /* global/remove_out_of_init_get_test.nit:30 */
    fra.me.prev = stack_frame_head; stack_frame_head = &fra.me;
    fra.me.file = LOCATE_global___remove_out_of_init_get_test;
    fra.me.line = 30;
    fra.me.meth = LOCATE_global___remove_out_of_init_get_test___Program___optimize_out_of_init_getters;
    fra.me.has_broke = 0;
    fra.me.REG_size = 2;
    fra.me.nitni_local_ref_head = NULL;
    fra.me.REG[0] = NIT_NULL;
    fra.me.REG[1] = NIT_NULL;
    fra.me.REG[0] = p0;
    fra.me.REG[1] = p1;
    /* global/remove_out_of_init_get_test.nit:31 */
    fra.me.REG[1] = CALL_global___reachable_from_init_method_analysis___Program___rfima(closctx->REG[0])(closctx->REG[0]);
    REGB0 = TAG_Bool(fra.me.REG[1]==NIT_NULL);
    if (UNTAG_Bool(REGB0)) {
      nit_abort("Reciever is null", NULL, LOCATE_global___remove_out_of_init_get_test, 31);
    }
    REGB0 = CALL_global___reachable_from_init_method_analysis___ReachableFromInitMethodAnalysis___is_iroutine_reachable_from_init(fra.me.REG[1])(fra.me.REG[1], fra.me.REG[0]);
    REGB0 = TAG_Bool(!UNTAG_Bool(REGB0));
    if (UNTAG_Bool(REGB0)) {
      /* global/remove_out_of_init_get_test.nit:32 */
      fra.me.REG[1] = NEW_GetterTestRemover_icode___icode_tools___ICodeVisitor___init();
      /* global/remove_out_of_init_get_test.nit:33 */
      CALL_icode___icode_tools___ICodeVisitor___visit_iroutine(fra.me.REG[1])(fra.me.REG[1], fra.me.REG[0]);
      /* global/remove_out_of_init_get_test.nit:34 */
      REGB0 = CALL_global___remove_out_of_init_get_test___Program___nb_optimized_isset(closctx->REG[0])(closctx->REG[0]);
      REGB1 = CALL_global___remove_out_of_init_get_test___GetterTestRemover___nb_optimized_isset(fra.me.REG[1])(fra.me.REG[1]);
      /* ../lib/standard/kernel.nit:245 */
      REGB1 = TAG_Int(UNTAG_Int(REGB0)+UNTAG_Int(REGB1));
      /* global/remove_out_of_init_get_test.nit:34 */
      ATTR_global___remove_out_of_init_get_test___Program____nb_optimized_isset(closctx->REG[0]) = REGB1;
    }
    stack_frame_head = fra.me.prev;
    return;
  }
static const char LOCATE_global___remove_out_of_init_get_test___Program___dump_out_of_init_information[] = "remove_out_of_init_get_test::Program::dump_out_of_init_information";
void global___remove_out_of_init_get_test___Program___dump_out_of_init_information(val_t p0, val_t p1){
  struct {struct stack_frame_t me; val_t MORE_REG[4];} fra;
  val_t REGB0;
  val_t tmp;
  static val_t once_value_1; /* Once value */
  static val_t once_value_2; /* Once value */
  static val_t once_value_3; /* Once value */
  static val_t once_value_5; /* Once value */
  static val_t once_value_6; /* Once value */
  static val_t once_value_7; /* Once value */
  static val_t once_value_8; /* Once value */
  fra.me.prev = stack_frame_head; stack_frame_head = &fra.me;
  fra.me.file = LOCATE_global___remove_out_of_init_get_test;
  fra.me.line = 39;
  fra.me.meth = LOCATE_global___remove_out_of_init_get_test___Program___dump_out_of_init_information;
  fra.me.has_broke = 0;
  fra.me.REG_size = 5;
  fra.me.nitni_local_ref_head = NULL;
  fra.me.REG[0] = NIT_NULL;
  fra.me.REG[1] = NIT_NULL;
  fra.me.REG[2] = NIT_NULL;
  fra.me.REG[3] = NIT_NULL;
  fra.me.REG[4] = NIT_NULL;
  fra.me.REG[0] = p0;
  fra.me.REG[1] = p1;
  /* global/remove_out_of_init_get_test.nit:41 */
  REGB0 = TAG_Int(5);
  fra.me.REG[2] = NEW_Array_standard___collection___array___Array___with_capacity(REGB0);
  if (!once_value_1) {
    fra.me.REG[3] = BOX_NativeString("");
    REGB0 = TAG_Int(0);
    fra.me.REG[3] = CALL_standard___string___NativeString___to_s_with_length(fra.me.REG[3])(fra.me.REG[3], REGB0);
    once_value_1 = fra.me.REG[3];
    register_static_object(&once_value_1);
  } else fra.me.REG[3] = once_value_1;
  fra.me.REG[3] = fra.me.REG[3];
  CALL_standard___collection___abstract_collection___SimpleCollection___add(fra.me.REG[2])(fra.me.REG[2], fra.me.REG[3]);
  CALL_standard___collection___abstract_collection___SimpleCollection___add(fra.me.REG[2])(fra.me.REG[2], fra.me.REG[1]);
  if (!once_value_2) {
    fra.me.REG[1] = BOX_NativeString("/");
    REGB0 = TAG_Int(1);
    fra.me.REG[1] = CALL_standard___string___NativeString___to_s_with_length(fra.me.REG[1])(fra.me.REG[1], REGB0);
    once_value_2 = fra.me.REG[1];
    register_static_object(&once_value_2);
  } else fra.me.REG[1] = once_value_2;
  fra.me.REG[1] = fra.me.REG[1];
  CALL_standard___collection___abstract_collection___SimpleCollection___add(fra.me.REG[2])(fra.me.REG[2], fra.me.REG[1]);
  fra.me.REG[1] = CALL_program___Program___main_module(fra.me.REG[0])(fra.me.REG[0]);
  fra.me.REG[1] = CALL_metamodel___abstractmetamodel___MMModule___name(fra.me.REG[1])(fra.me.REG[1]);
  fra.me.REG[1] = CALL_standard___string___Object___to_s(fra.me.REG[1])(fra.me.REG[1]);
  CALL_standard___collection___abstract_collection___SimpleCollection___add(fra.me.REG[2])(fra.me.REG[2], fra.me.REG[1]);
  if (!once_value_3) {
    fra.me.REG[1] = BOX_NativeString(".out_of_init_opt.log");
    REGB0 = TAG_Int(20);
    fra.me.REG[1] = CALL_standard___string___NativeString___to_s_with_length(fra.me.REG[1])(fra.me.REG[1], REGB0);
    once_value_3 = fra.me.REG[1];
    register_static_object(&once_value_3);
  } else fra.me.REG[1] = once_value_3;
  fra.me.REG[1] = fra.me.REG[1];
  CALL_standard___collection___abstract_collection___SimpleCollection___add(fra.me.REG[2])(fra.me.REG[2], fra.me.REG[1]);
  fra.me.REG[2] = CALL_standard___string___Object___to_s(fra.me.REG[2])(fra.me.REG[2]);
  fra.me.REG[2] = NEW_OFStream_standard___file___OFStream___open(fra.me.REG[2]);
  /* global/remove_out_of_init_get_test.nit:42 */
  REGB0 = TAG_Int(0);
  fra.me.REG[1] = REGB0;
  CALL_program___Program___with_each_iroutines(fra.me.REG[0])(fra.me.REG[0], (&(fra.me)), ((fun_t)OC_global___remove_out_of_init_get_test___Program___dump_out_of_init_information_4));
  /* global/remove_out_of_init_get_test.nit:50 */
  REGB0 = TAG_Int(3);
  fra.me.REG[3] = NEW_Array_standard___collection___array___Array___with_capacity(REGB0);
  if (!once_value_5) {
    fra.me.REG[4] = BOX_NativeString("Nb. optimized isset: ");
    REGB0 = TAG_Int(21);
    fra.me.REG[4] = CALL_standard___string___NativeString___to_s_with_length(fra.me.REG[4])(fra.me.REG[4], REGB0);
    once_value_5 = fra.me.REG[4];
    register_static_object(&once_value_5);
  } else fra.me.REG[4] = once_value_5;
  fra.me.REG[4] = fra.me.REG[4];
  CALL_standard___collection___abstract_collection___SimpleCollection___add(fra.me.REG[3])(fra.me.REG[3], fra.me.REG[4]);
  REGB0 = CALL_global___remove_out_of_init_get_test___Program___nb_optimized_isset(fra.me.REG[0])(fra.me.REG[0]);
  fra.me.REG[0] = CALL_standard___string___Object___to_s(REGB0)(REGB0);
  CALL_standard___collection___abstract_collection___SimpleCollection___add(fra.me.REG[3])(fra.me.REG[3], fra.me.REG[0]);
  if (!once_value_6) {
    fra.me.REG[0] = BOX_NativeString("\n");
    REGB0 = TAG_Int(1);
    fra.me.REG[0] = CALL_standard___string___NativeString___to_s_with_length(fra.me.REG[0])(fra.me.REG[0], REGB0);
    once_value_6 = fra.me.REG[0];
    register_static_object(&once_value_6);
  } else fra.me.REG[0] = once_value_6;
  fra.me.REG[0] = fra.me.REG[0];
  CALL_standard___collection___abstract_collection___SimpleCollection___add(fra.me.REG[3])(fra.me.REG[3], fra.me.REG[0]);
  fra.me.REG[3] = CALL_standard___string___Object___to_s(fra.me.REG[3])(fra.me.REG[3]);
  CALL_standard___stream___OStream___write(fra.me.REG[2])(fra.me.REG[2], fra.me.REG[3]);
  /* global/remove_out_of_init_get_test.nit:51 */
  REGB0 = TAG_Int(3);
  fra.me.REG[3] = NEW_Array_standard___collection___array___Array___with_capacity(REGB0);
  if (!once_value_7) {
    fra.me.REG[0] = BOX_NativeString("Nb. not optimized: ");
    REGB0 = TAG_Int(19);
    fra.me.REG[0] = CALL_standard___string___NativeString___to_s_with_length(fra.me.REG[0])(fra.me.REG[0], REGB0);
    once_value_7 = fra.me.REG[0];
    register_static_object(&once_value_7);
  } else fra.me.REG[0] = once_value_7;
  fra.me.REG[0] = fra.me.REG[0];
  CALL_standard___collection___abstract_collection___SimpleCollection___add(fra.me.REG[3])(fra.me.REG[3], fra.me.REG[0]);
  fra.me.REG[1] = CALL_standard___string___Object___to_s(fra.me.REG[1])(fra.me.REG[1]);
  CALL_standard___collection___abstract_collection___SimpleCollection___add(fra.me.REG[3])(fra.me.REG[3], fra.me.REG[1]);
  if (!once_value_8) {
    fra.me.REG[1] = BOX_NativeString("\n");
    REGB0 = TAG_Int(1);
    fra.me.REG[1] = CALL_standard___string___NativeString___to_s_with_length(fra.me.REG[1])(fra.me.REG[1], REGB0);
    once_value_8 = fra.me.REG[1];
    register_static_object(&once_value_8);
  } else fra.me.REG[1] = once_value_8;
  fra.me.REG[1] = fra.me.REG[1];
  CALL_standard___collection___abstract_collection___SimpleCollection___add(fra.me.REG[3])(fra.me.REG[3], fra.me.REG[1]);
  fra.me.REG[3] = CALL_standard___string___Object___to_s(fra.me.REG[3])(fra.me.REG[3]);
  CALL_standard___stream___OStream___write(fra.me.REG[2])(fra.me.REG[2], fra.me.REG[3]);
  /* global/remove_out_of_init_get_test.nit:53 */
  CALL_standard___stream___IOS___close(fra.me.REG[2])(fra.me.REG[2]);
  stack_frame_head = fra.me.prev;
  return;
}
  void OC_global___remove_out_of_init_get_test___Program___dump_out_of_init_information_4(struct stack_frame_t *closctx, val_t p0, val_t p1){
    struct {struct stack_frame_t me; val_t MORE_REG[1];} fra;
    val_t REGB0;
    val_t tmp;
    /* global/remove_out_of_init_get_test.nit:44 */
    fra.me.prev = stack_frame_head; stack_frame_head = &fra.me;
    fra.me.file = LOCATE_global___remove_out_of_init_get_test;
    fra.me.line = 44;
    fra.me.meth = LOCATE_global___remove_out_of_init_get_test___Program___dump_out_of_init_information;
    fra.me.has_broke = 0;
    fra.me.REG_size = 2;
    fra.me.nitni_local_ref_head = NULL;
    fra.me.REG[0] = NIT_NULL;
    fra.me.REG[1] = NIT_NULL;
    fra.me.REG[0] = p0;
    fra.me.REG[1] = p1;
    /* global/remove_out_of_init_get_test.nit:45 */
    fra.me.REG[1] = NEW_IssetCounter_icode___icode_tools___ICodeVisitor___init();
    /* global/remove_out_of_init_get_test.nit:46 */
    CALL_icode___icode_tools___ICodeVisitor___visit_iroutine(fra.me.REG[1])(fra.me.REG[1], fra.me.REG[0]);
    /* global/remove_out_of_init_get_test.nit:47 */
    REGB0 = CALL_global___remove_out_of_init_get_test___IssetCounter___nb_isset(fra.me.REG[1])(fra.me.REG[1]);
    /* ../lib/standard/kernel.nit:245 */
    REGB0 = TAG_Int(UNTAG_Int(closctx->REG[1])+UNTAG_Int(REGB0));
    /* global/remove_out_of_init_get_test.nit:47 */
    closctx->REG[1] = REGB0;
    stack_frame_head = fra.me.prev;
    return;
  }
static const char LOCATE_global___remove_out_of_init_get_test___IssetCounter___nb_isset[] = "remove_out_of_init_get_test::IssetCounter::nb_isset";
val_t global___remove_out_of_init_get_test___IssetCounter___nb_isset(val_t p0){
  struct {struct stack_frame_t me;} fra;
  val_t REGB0;
  val_t tmp;
  fra.me.prev = stack_frame_head; stack_frame_head = &fra.me;
  fra.me.file = LOCATE_global___remove_out_of_init_get_test;
  fra.me.line = 59;
  fra.me.meth = LOCATE_global___remove_out_of_init_get_test___IssetCounter___nb_isset;
  fra.me.has_broke = 0;
  fra.me.REG_size = 1;
  fra.me.nitni_local_ref_head = NULL;
  fra.me.REG[0] = NIT_NULL;
  fra.me.REG[0] = p0;
  /* global/remove_out_of_init_get_test.nit:59 */
  REGB0 = TAG_Bool(ATTR_global___remove_out_of_init_get_test___IssetCounter____nb_isset(fra.me.REG[0])!=NIT_NULL);
  if (UNTAG_Bool(REGB0)) {
  } else {
    nit_abort("Uninitialized attribute %s", "_nb_isset", LOCATE_global___remove_out_of_init_get_test, 59);
  }
  REGB0 = ATTR_global___remove_out_of_init_get_test___IssetCounter____nb_isset(fra.me.REG[0]);
  stack_frame_head = fra.me.prev;
  return REGB0;
}
static const char LOCATE_global___remove_out_of_init_get_test___IssetCounter___visit_icode[] = "remove_out_of_init_get_test::IssetCounter::(icode_tools::ICodeVisitor::visit_icode)";
void global___remove_out_of_init_get_test___IssetCounter___visit_icode(val_t p0, val_t p1){
  struct {struct stack_frame_t me; val_t MORE_REG[3];} fra;
  val_t REGB0;
  val_t REGB1;
  val_t tmp;
  fra.me.prev = stack_frame_head; stack_frame_head = &fra.me;
  fra.me.file = LOCATE_global___remove_out_of_init_get_test;
  fra.me.line = 61;
  fra.me.meth = LOCATE_global___remove_out_of_init_get_test___IssetCounter___visit_icode;
  fra.me.has_broke = 0;
  fra.me.REG_size = 4;
  fra.me.nitni_local_ref_head = NULL;
  fra.me.REG[0] = NIT_NULL;
  fra.me.REG[1] = NIT_NULL;
  fra.me.REG[2] = NIT_NULL;
  fra.me.REG[3] = NIT_NULL;
  fra.me.REG[0] = p0;
  fra.me.REG[1] = p1;
  /* global/remove_out_of_init_get_test.nit:61 */
  fra.me.REG[2] = fra.me.REG[0];
  fra.me.REG[3] = fra.me.REG[1];
  /* global/remove_out_of_init_get_test.nit:63 */
  REGB0 = TAG_Bool((fra.me.REG[3]!=NIT_NULL) && VAL_ISA(fra.me.REG[3], COLOR_icode___icode_base___IAttrIsset, ID_icode___icode_base___IAttrIsset)) /*cast IAttrIsset*/;
  if (UNTAG_Bool(REGB0)) {
    /* global/remove_out_of_init_get_test.nit:64 */
    REGB0 = CALL_global___remove_out_of_init_get_test___IssetCounter___nb_isset(fra.me.REG[2])(fra.me.REG[2]);
    REGB1 = TAG_Int(1);
    /* ../lib/standard/kernel.nit:245 */
    REGB1 = TAG_Int(UNTAG_Int(REGB0)+UNTAG_Int(REGB1));
    /* global/remove_out_of_init_get_test.nit:64 */
    ATTR_global___remove_out_of_init_get_test___IssetCounter____nb_isset(fra.me.REG[2]) = REGB1;
  }
  /* global/remove_out_of_init_get_test.nit:67 */
  CALL_SUPER_global___remove_out_of_init_get_test___IssetCounter___visit_icode(fra.me.REG[0])(fra.me.REG[0], fra.me.REG[1]);
  stack_frame_head = fra.me.prev;
  return;
}
static const char LOCATE_global___remove_out_of_init_get_test___GetterTestRemover___nb_optimized_isset[] = "remove_out_of_init_get_test::GetterTestRemover::nb_optimized_isset";
val_t global___remove_out_of_init_get_test___GetterTestRemover___nb_optimized_isset(val_t p0){
  struct {struct stack_frame_t me;} fra;
  val_t REGB0;
  val_t tmp;
  fra.me.prev = stack_frame_head; stack_frame_head = &fra.me;
  fra.me.file = LOCATE_global___remove_out_of_init_get_test;
  fra.me.line = 73;
  fra.me.meth = LOCATE_global___remove_out_of_init_get_test___GetterTestRemover___nb_optimized_isset;
  fra.me.has_broke = 0;
  fra.me.REG_size = 1;
  fra.me.nitni_local_ref_head = NULL;
  fra.me.REG[0] = NIT_NULL;
  fra.me.REG[0] = p0;
  /* global/remove_out_of_init_get_test.nit:73 */
  REGB0 = TAG_Bool(ATTR_global___remove_out_of_init_get_test___GetterTestRemover____nb_optimized_isset(fra.me.REG[0])!=NIT_NULL);
  if (UNTAG_Bool(REGB0)) {
  } else {
    nit_abort("Uninitialized attribute %s", "_nb_optimized_isset", LOCATE_global___remove_out_of_init_get_test, 73);
  }
  REGB0 = ATTR_global___remove_out_of_init_get_test___GetterTestRemover____nb_optimized_isset(fra.me.REG[0]);
  stack_frame_head = fra.me.prev;
  return REGB0;
}
static const char LOCATE_global___remove_out_of_init_get_test___GetterTestRemover___visit_icode[] = "remove_out_of_init_get_test::GetterTestRemover::(icode_tools::ICodeVisitor::visit_icode)";
void global___remove_out_of_init_get_test___GetterTestRemover___visit_icode(val_t p0, val_t p1){
  struct {struct stack_frame_t me; val_t MORE_REG[4];} fra;
  val_t REGB0;
  val_t REGB1;
  val_t tmp;
  fra.me.prev = stack_frame_head; stack_frame_head = &fra.me;
  fra.me.file = LOCATE_global___remove_out_of_init_get_test;
  fra.me.line = 75;
  fra.me.meth = LOCATE_global___remove_out_of_init_get_test___GetterTestRemover___visit_icode;
  fra.me.has_broke = 0;
  fra.me.REG_size = 5;
  fra.me.nitni_local_ref_head = NULL;
  fra.me.REG[0] = NIT_NULL;
  fra.me.REG[1] = NIT_NULL;
  fra.me.REG[2] = NIT_NULL;
  fra.me.REG[3] = NIT_NULL;
  fra.me.REG[4] = NIT_NULL;
  fra.me.REG[0] = p0;
  fra.me.REG[1] = p1;
  /* global/remove_out_of_init_get_test.nit:75 */
  fra.me.REG[2] = fra.me.REG[0];
  fra.me.REG[3] = fra.me.REG[1];
  /* global/remove_out_of_init_get_test.nit:78 */
  REGB0 = TAG_Bool((fra.me.REG[3]!=NIT_NULL) && VAL_ISA(fra.me.REG[3], COLOR_icode___icode_base___IAttrIsset, ID_icode___icode_base___IAttrIsset)) /*cast IAttrIsset*/;
  if (UNTAG_Bool(REGB0)) {
    /* global/remove_out_of_init_get_test.nit:79 */
    REGB0 = TAG_Bool(fra.me.REG[3]==NIT_NULL);
    if (UNTAG_Bool(REGB0)) {
      nit_abort("Reciever is null", NULL, LOCATE_global___remove_out_of_init_get_test, 79);
    }
    fra.me.REG[3] = CALL_icode___icode_base___ICode___result(fra.me.REG[3])(fra.me.REG[3]);
    /* global/remove_out_of_init_get_test.nit:80 */
    REGB0 = TAG_Bool(fra.me.REG[3]==NIT_NULL);
    if (UNTAG_Bool(REGB0)) {
    } else {
      REGB1 = TAG_Bool(fra.me.REG[3]==NIT_NULL);
      if (UNTAG_Bool(REGB1)) {
        REGB1 = TAG_Bool(0);
        REGB0 = REGB1;
      } else {
        REGB1 = CALL_standard___kernel___Object_____eqeq(fra.me.REG[3])(fra.me.REG[3], NIT_NULL);
        REGB0 = REGB1;
      }
    }
    REGB0 = TAG_Bool(!UNTAG_Bool(REGB0));
    if (UNTAG_Bool(REGB0)) {
    } else {
      nit_abort("Assert failed", NULL, LOCATE_global___remove_out_of_init_get_test, 80);
    }
    /* global/remove_out_of_init_get_test.nit:81 */
    REGB0 = TAG_Bool(1);
    fra.me.REG[4] = NEW_IBoolValue_icode___icode_base___IBoolValue___init(REGB0);
    /* global/remove_out_of_init_get_test.nit:82 */
    CALL_icode___icode_base___ICode___result__eq(fra.me.REG[4])(fra.me.REG[4], fra.me.REG[3]);
    /* global/remove_out_of_init_get_test.nit:83 */
    fra.me.REG[3] = CALL_icode___icode_tools___ICodeVisitor___current_icode(fra.me.REG[2])(fra.me.REG[2]);
    REGB0 = TAG_Bool(fra.me.REG[3]==NIT_NULL);
    if (UNTAG_Bool(REGB0)) {
      nit_abort("Reciever is null", NULL, LOCATE_global___remove_out_of_init_get_test, 83);
    }
    CALL_standard___collection___list___ListIterator___insert_before(fra.me.REG[3])(fra.me.REG[3], fra.me.REG[4]);
    /* global/remove_out_of_init_get_test.nit:84 */
    fra.me.REG[4] = CALL_icode___icode_tools___ICodeVisitor___current_icode(fra.me.REG[2])(fra.me.REG[2]);
    REGB0 = TAG_Bool(fra.me.REG[4]==NIT_NULL);
    if (UNTAG_Bool(REGB0)) {
      nit_abort("Reciever is null", NULL, LOCATE_global___remove_out_of_init_get_test, 84);
    }
    CALL_standard___collection___list___ListIterator___delete(fra.me.REG[4])(fra.me.REG[4]);
    /* global/remove_out_of_init_get_test.nit:85 */
    REGB0 = CALL_global___remove_out_of_init_get_test___GetterTestRemover___nb_optimized_isset(fra.me.REG[2])(fra.me.REG[2]);
    REGB1 = TAG_Int(1);
    /* ../lib/standard/kernel.nit:245 */
    REGB1 = TAG_Int(UNTAG_Int(REGB0)+UNTAG_Int(REGB1));
    /* global/remove_out_of_init_get_test.nit:85 */
    ATTR_global___remove_out_of_init_get_test___GetterTestRemover____nb_optimized_isset(fra.me.REG[2]) = REGB1;
  }
  /* global/remove_out_of_init_get_test.nit:88 */
  CALL_SUPER_global___remove_out_of_init_get_test___GetterTestRemover___visit_icode(fra.me.REG[0])(fra.me.REG[0], fra.me.REG[1]);
  stack_frame_head = fra.me.prev;
  return;
}
