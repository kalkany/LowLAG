
 add_fsm_encoding \
       {iis_deser.iis_state} \
       { }  \
       {{000 000} {001 001} {010 010} {011 011} {100 100} {101 101} {110 110} }

 add_fsm_encoding \
       {iis_ser.iis_state} \
       { }  \
       {{000 00001} {001 00010} {010 00100} {011 01000} {100 10000} }
