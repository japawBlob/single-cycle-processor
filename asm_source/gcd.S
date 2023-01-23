
#define zero	$0
#define AT	$1
#define v0 	$2
#define v1	$3
#define a0	$4
#define a1	$5
#define a2	$6
#define	a3	$7

#define t0	$8
#define t1	$9
#define t2	$10
#define t3	$11
#define t4	$12
#define t5	$13
#define t6	$14
#define t7	$15
#define t8	$24
#define t9	$25
#define k0	$26
#define k1	$27

#define s0	$16
#define s1	$17
#define s2	$18
#define s3	$19
#define s4	$20
#define s5	$21
#define s6	$22
#define s7	$23

#define gp	$28
#define sp	$29
#define fp	$30
#define ra	$31

.globl start
.globl _start
.set noat
.set noreorder
.ent start

# https://en.wikipedia.org/wiki/Binary_GCD_algorithm

start:
_start:

addi    s1, zero, 1;                # register for const 1
gcd:
    lw  t1, 0x4(zero);
    lw  t2, 0x8(zero); 
    beq t1, zero, ret_v;
    nop;
    beq t2, zero, ret_u;
    nop;
    beq t1, t2, ret_u;
    nop;
    add t4, zero, zero;
    loop1:
        or  t3, t1, t2;
        and t3, t3, s1;
        bne t3, zero, loop1_end;
        nop;
        addi t4, t4, 1;
        srl t1, t1, 1;
        srl t2, t2, 1;
        beq zero, zero, loop1;
        nop;
    loop1_end:
    loop2:
        and t3, t1, s1;
        bne t3, zero, loop2_end;
        nop;
        srl t1, t1, 1;
        beq zero, zero, loop2;
        nop;
    loop2_end:
    loop3:
        loop3_inner:
            and t3, t2, s1;
            bne t3, zero, loop3_inner_end;
            srl t2, t2, 1;
            beq zero, zero, loop3_inner;
            nop;
        loop3_inner_end:
        slt s2, t2, t1;   # s2 = t2 < t1 
        bne s2, s1, no_swap;
        nop;
            add t3, t1, zero;
            add t1, t2, zero;
            add t2, t3, zero;
        no_swap:
        sub t2, t2, t1;
        bne t2, zero, loop3;
        nop;
    loop3_end:
    shift_loop:
        beq t4, zero, skip_shift_loop;
        nop;
        sub t4, t4, s1;
        sll t1, t1, 1;
        beq zero, zero, shift_loop;
        nop;
    skip_shift_loop:
    ret_u:
        sw  t1, 0xC(zero);
        beq zero, zero, done;
        nop;
    ret_v:
        sw  t2, 0xC(zero);
        beq zero, zero, done;
done:
    nop;
.end start
