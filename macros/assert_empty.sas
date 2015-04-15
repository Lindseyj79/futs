/* ----------------------------------------------------------------
 * <doc>
 * @purpose Generates an event if a data set has any observations;
 *  no event if data set does not exist.
 * @param DS - Name of data set to check
 * @param TYPE - The event type, a string that describes a kind of event
 * @param LEVEL - The severity level of the event (ERROR|WARNING|INFO|DEBUG)
 * @param MESSAGE - A text message explaining the event details.
 * @param ATTACHDATA - A space-delimited list of data sets to attach to the
 *  event.
 * @param ATTACHFILE - A fully-qualified delimited list of files to attach
 *  to the event.  Use &PATHSEP as a delimiter.
 * @param METRIC - Optional numeric metric associated with event
 * @param PROPERTIES - Optional event custom properties.  Format is 
 *  /prop1=val1/prop2=val2/.  The first character defines the separator,
 *  and can be a character other than '/'.  An arbitrary number of 
 *  properties may be passed in this format.
 * @param ON_EVENT - Optional block of SAS code to execute 
 *  if the event is fired.
 * @param ABORT - Flag instructing the event system if it should end
 *  the SAS session and stop the batch run.  Valid values are
 *  (YES|TRUE|NO|FALSE)
 * @macro %generate_event
 * </doc>
 *
 * FUTS v1.1
 * Copyright (c) 2002 ThotWave Technologies, LLC. All rights reserved.
 * ---------------------------------------------------------------- */

%macro assert_empty( DS,
        MESSAGE=Data set &DS not empty,
        TYPE=,
        LEVEL=,
        ATTACHDATA=,
        ATTACHFILE=,
        METRIC=,
        PROPERTIES=,
        ON_EVENT=,
        ABORT= );

%let futs_tst_cnt = %eval(&futs_tst_cnt.+1);
    
%if %exist(&DS) %then
  %if %obs(&DS) > 0 %then
    %generate_event(TYPE=&TYPE, LEVEL=&LEVEL, 
         MESSAGE=&MESSAGE,
         ATTACHDATA=&ATTACHDATA, ATTACHFILE=&ATTACHFILE,
         METRIC=&METRIC,
         PROPERTIES=&PROPERTIES,
         ON_EVENT=&ON_EVENT,
         ABORT=&ABORT);

%mend assert_empty;
