;;                                       ACTIVE BIT
;;                                       |    
;; 1111 0000 1111 0000 1111 0000 1111 0000
;;          |         |    |    |    |
;; X        |Y        |R G  B A |    |TYPE 

;; ROW 1 DATA
(global $alien_data_location i32 (i32.const 265000))
(global $alien_row_bytes i32 (i32.const 40))
(global $alien_row_count i32 (i32.const 5))
(global $alien_byte_count i32 (i32.const 200))

(global $shot_count i32 (i32.const 10))
(global $shot_index (mut i32) (i32.const 0))
(global $shot_speed i32 (i32.const 4))
(global $shot_frame (mut i32) (i32.const 0))

(global $explosion_data_location i32 (i32.const 265250))
(global $explosion_count i32 (i32.const 10))
(global $explosion_index (mut i32) (i32.const 0))

;; EXPLOSION                             ACTIVE BIT
;;                                       |    
;; 1111 0000 1111 0000 1111 0000 1111 0000
;;               |              |    
;; X             |Y             |FRAME   |

;; data is little endian
(data (i32.const 265000) 
;; 1           2           3           4           5           6           7           8           9          10
  "\05\fb\14\14\05\fb\14\28\05\fb\14\3c\05\fb\14\50\05\fb\14\64\05\fb\14\78\05\fb\14\8c\05\fb\14\a0\05\fb\14\b4\05\fb\14\c8")

(data (i32.const 265040) 
  "\03\f3\28\14\03\f3\28\28\03\f3\28\3c\03\f3\28\50\03\f3\28\64\03\f3\28\78\03\f3\28\8c\03\f3\28\a0\03\f3\28\b4\03\f3\28\c8")
;; 1           2           3           4           5           6           7           8           9          10
(data (i32.const 265080) 
;; 1           2           3           4           5           6           7           8           9          10
  "\07\c3\3c\14\07\c3\3c\28\07\c3\3c\3c\07\c3\3c\50\07\c3\3c\64\07\c3\3c\78\07\c3\3c\8c\07\c3\3c\a0\07\c3\3c\b4\07\c3\3c\c8")

(data (i32.const 265120) 
;; 1           2           3           4           5           6           7           8           9          10
  "\03\cf\50\14\03\cf\50\28\03\cf\50\3c\03\cf\50\50\03\cf\50\64\03\cf\50\78\03\cf\50\8c\03\cf\50\a0\03\cf\50\b4\03\cf\50\c8")

(data (i32.const 265160) 
;; 1           2           3           4           5           6           7           8           9          10
  "\07\3f\64\14\07\3f\64\28\07\3f\64\3c\07\3f\64\50\07\3f\64\64\07\3f\64\78\07\3f\64\8c\07\3f\64\a0\07\3f\64\b4\07\3f\64\c8")

(data (i32.const 265200) 
  "\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00") 



