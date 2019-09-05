Converting all character variables to numeric with the same name;                                                    
                                                                                                                     
 Two Solutions                                                                                                       
                                                                                                                     
     a. array do_over                                                                                                
     b. dosubl                                                                                                       
                                                                                                                     
Broken record, but you wont find these solutions in the SAS forum.                                                   
It is worth repeating.                                                                                               
                                                                                                                     
github                                                                                                               
https://tinyurl.com/y554ztrd                                                                                         
https://github.com/rogerjdeangelis/utl-converting-all-character-variables-to-numeric-with-the-same-name              
                                                                                                                     
SAS Forum                                                                                                            
https://tinyurl.com/y4gdmqxk                                                                                         
https://communities.sas.com/t5/SAS-Programming/how-to-make-the-type-of-all-the-variables-same/m-p/585730             
                                                                                                                     
macros                                                                                                               
https://tinyurl.com/y9nfugth                                                                                         
https://github.com/rogerjdeangelis/utl-macros-used-in-many-of-rogerjdeangelis-repositories                           
                                                                                                                     
                                                                                                                     
                                                                                                                     
data have;                                                                                                           
                                                                                                                     
  retain rec;                                                                                                        
                                                                                                                     
  set sashelp.class(keep=age obs=5);                                                                                 
                                                                                                                     
  rec=1000*_n_;                                                                                                      
  weight=put(80 + int(100*uniform(3456)),5.);                                                                        
  height=put(48 + int(30*uniform(3456)),5.);                                                                         
                                                                                                                     
run;quit;                                                                                                            
                                                                                                                     
*_                   _                                                                                               
(_)_ __  _ __  _   _| |_                                                                                             
| | '_ \| '_ \| | | | __|                                                                                            
| | | | | |_) | |_| | |_                                                                                             
|_|_| |_| .__/ \__,_|\__|                                                                                            
        |_|                                                                                                          
;                                                                                                                    
                                                                                                                     
Variables in Creation Order                                                                                          
                                                                                                                     
  Variable    Type    Len                                                                                            
                                                                                                                     
  REC         Num       8                                                                                            
  AGE         Num       8                                                                                            
                                                                                                                     
  WEIGHT      Char      5  Change to numeric with same name                                                          
  HEIGHT      Char      5                                                                                            
                                                                                                                     
*            _               _                                                                                       
  ___  _   _| |_ _ __  _   _| |_                                                                                     
 / _ \| | | | __| '_ \| | | | __|                                                                                    
| (_) | |_| | |_| |_) | |_| | |_                                                                                     
 \___/ \__,_|\__| .__/ \__,_|\__|                                                                                    
                |_|                                                                                                  
;                                                                                                                    
                                                                                                                     
character variables converted to numeric for 5  observations                                                         
                                                                                                                     
 Variables in Creation Order                                                                                         
                                                                                                                     
#    Variable    Type    Len                                                                                         
                                                                                                                     
1    REC         Num       8                                                                                         
2    AGE         Num       8                                                                                         
                                                                                                                     
3    WEIGHT      Num       8  Now numeric                                                                            
4    HEIGHT      Num       8                                                                                         
                                                                                                                     
*          _       _   _                                                                                             
 ___  ___ | |_   _| |_(_) ___  _ __  ___                                                                             
/ __|/ _ \| | | | | __| |/ _ \| '_ \/ __|                                                                            
\__ \ (_) | | |_| | |_| | (_) | | | \__ \                                                                            
|___/\___/|_|\__,_|\__|_|\___/|_| |_|___/                                                                            
                                                                                                                     
  __ _      __ _ _ __ _ __ __ _ _   _                                                                                
 / _` |    / _` | '__| '__/ _` | | | |                                                                               
| (_| |_  | (_| | |  | | | (_| | |_| |                                                                               
 \__,_(_)  \__,_|_|  |_|  \__,_|\__, |                                                                               
                                |___/                                                                                
;                                                                                                                    
                                                                                                                     
%array(chrs,values=%varlist(have,keep=_character_));                                                                 
%array(nums,values=%varlist(have,keep=_numeric_));                                                                   
                                                                                                                     
%put &=chrs2; * CHRS2=HEIGHT;                                                                                        
%put &=nums2; * NUMS2=AGE   ;                                                                                        
                                                                                                                     
proc sql;                                                                                                            
  create                                                                                                             
      table want as                                                                                                  
  select                                                                                                             
      %do_over(nums,phrase=?, between=comma)                                                                         
     ,%do_over(chrs,phrase=%str(input(?,best.) as ?), between=comma)                                                 
  from                                                                                                               
     have                                                                                                            
;quit;                                                                                                               
                                                                                                                     
                                                                                                                     
*_            _                 _     _                                                                              
| |__      __| | ___  ___ _   _| |__ | |                                                                             
| '_ \    / _` |/ _ \/ __| | | | '_ \| |                                                                             
| |_) |  | (_| | (_) \__ \ |_| | |_) | |                                                                             
|_.__(_)  \__,_|\___/|___/\__,_|_.__/|_|                                                                             
                                                                                                                     
;                                                                                                                    
                                                                                                                     
%array(chrs,values=%varlist(have,keep=_character_));                                                                 
%array(nums,values=%varlist(have,keep=_numeric_));                                                                   
                                                                                                                     
data log;                                                                                                            
                                                                                                                     
  rc=dosubl('                                                                                                        
    proc sql;                                                                                                        
      create                                                                                                         
          table want as                                                                                              
      select                                                                                                         
          %do_over(nums,phrase=?, between=comma)                                                                     
         ,%do_over(chrs,phrase=%str(input(?,best.) as ?), between=comma)                                             
      from                                                                                                           
         have                                                                                                        
    ;quit;                                                                                                           
    %let obs=&sqlobs;                                                                                                
    ');                                                                                                              
    obs=symgetn("obs");                                                                                              
    put "character variables converted to numeric for " obs " observations";                                         
                                                                                                                     
    stop;                                                                                                            
                                                                                                                     
run;quit;                                                                                                            
