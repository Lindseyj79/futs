/*  Source: testunit.sas
 *
 *  Author : John Jacobs
 *  Date   : 15-04-2015
 *  Licence: Eclipse Public License
 *  
 *  version: 1.1
 *  as of  : 19-04-2015
 *  
 *  SAS version: 9.3
 *  
 *  Purpose: Perform a unittest on a user defined source file.
 *  
 *  Method: The user needs to modify the program to;
 *          - set &futs_program_directory. to the directory where the source file that
 *            is to be tested resides.
 *          - set &futs_src. to the name of the source file to be tested.
 *          
 *          The user must then modify this file to include the tests that are to be run
 *          against the source file.
 *          
 *          When the program is run it will:
 *          1) create a file reference for the test report;
 *          2) include and execute the setup file;
 *          3) include the file that is to be tested;
 *          4) perform the unit tests and create a test report;
 *          5) include and execute the teardown file.
 *              
 *  Modified FUTS v1.1
 *  Copyright (c) 2015 John Jacobs. All rights reserved.
 */


/* Modified futs specific code.
 */
  %let futs_program_directory = /folders/myfolders/functions;
  %let futs_src = stress1.sas;
  
  filename futs_rpt "&futs_program_directory./futs/test_report.txt"; 
  
  %include "&futs_program_directory./futs/setup.sas";
  %include "&futs_program_directory./&futs_src.";
  
/* ******************************************************************************************** */

%macro test_init;
  %let futs_macro_name = &sysmacroname.;
  %futs_case_init('werk voorbereiding');

  %init;
  
  %assert_zero(%sysfunc(libref(clinic)),message=Library 'clinic' not assigned);
  %assert_fexist(tests);
  
  %futs_case_finish;
%mend;

%macro test_import;
  %let futs_macro_name = &sysmacroname.;
  %futs_case_init('gegevens invoer');
  
  %import_data;
  
  %assert_exist(clinic.stress1);
  %assert_equal(%obs(clinic.stress), 6, description='aantal records wijkt af');
  
  %futs_case_finish;
%mend;

%macro test_prepare;
  %let futs_macro_name = &sysmacroname.;
  %futs_case_init('gegevens verwerking');

  %prepare_data;
  %assert_exist(work.stress);

  %local first_hr;
  %local last_hr;
  
  data _null_;
      set work.stress end=eof;
      
      if _n_ = 1 then
      do;
        call symputx('first_hr', resthr);
      end;
      
      if eof then
      do;
        call symputx('last_hr', resthr);
      end;
  run;    
  
  %assert_sym_compare(&first_hr., &last_hr., gt, description='dataset niet gesorteerd op rust hartslag');
  
  %futs_case_finish;
%mend;

%test_init;
%test_import;
%test_prepare;
 
/* ******************************************************************************************** */

/* Modified futs specific code.
 */
  %futs_tot_finish;
  %include "&futs_program_directory./futs/teardown.sas";
  
