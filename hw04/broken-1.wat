(module
 (import "" "write_i32"  (func $write_i32  (param i32)))
 (import "" "write_i32x" (func $write_i32x (param i32)))
 (import "" "write_i32b" (func $write_i32b (param i32)))
 (import "" "write_char" (func $write_char (param i32)))
 (memory 1)
 (data (offset (i32.const 16))
   "\F1\00\00\00"
   "\F2\00\00\00"
   "\F3\00\00\00"
   "\F4\00\00\00"
   "\F5\00\00\00"
   "\F6\00\00\00"
   "\F7\00\00\00"
   "\F8\00\00\00"
   "\F9\00\00\00"
   "\FA\00\00\00"
 )
 (func $run (export "run") (result i32)
   (local $counter i32)
   i32.const 10
   local.set $counter
   block $done
     loop $repeat
       local.get $counter
       i32.const 1
       i32.sub
       local.set $counter
       local.get $counter
       i32.const 4
       i32.mul
       i32.const 16
       i32.add
       i32.load
       call $write_i32x
       i32.const 10
       call $write_char
       local.get $counter
       br_if $repeat
     end $repeat
   end $done
   i32.const 0
 )
)