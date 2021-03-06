/*  Source: teardown.sas
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
 *  Purpose: To be included in programs that use modified futs unit testing.
 *  
 *  Method: This file needs to be included in the unittest file to tear down the
 *          environment after modified futs unit testing. It performs two standard functions:
 *          - releases the file reference futs_rpt;
 *          - Deletes all macro variables created for the execution of the unittest.
 *          
 *          The user can modify this file to execute application specific teardown code.
 *
 *  Modified FUTS v1.1
 *  Copyright (c) 2015 John Jacobs. All rights reserved.
 */


/* ******************************************************************************************** */

/* <application specific code goes here> */

/* ******************************************************************************************** */


/* Modified futs specific teardown code.
 */
  filename futs_rpt;
  
  %symdel futs_tst_err 
          futs_tot_err 
          futs_tst_cnt
          futs_tot_cnt
          futs_program_directory
          futs_src
          futs_directory
          futs_macro_name
          futs_max_tests
          futs_case_description;
