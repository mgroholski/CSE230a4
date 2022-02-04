###########################################################
# Assignment #: 4
#  Name: Matthew Groholski
#  ASU email: mgrohols@asu.edu
#  Course: CSE/EEE230, TTh 3PM
#  Description: -write assembly language programs to: 
#            -perform decision making using branch instructions. 
#            -use syscall operations to display integers and strings on the console window 
#            -use syscall operations to read integers from the keyboard.
###########################################################
.data
#Storing all of the messages
newline: .asciiz "\n"
dash: .asciiz "-----------------------------------------------\n"
m1: .asciiz "How many T-shirts would you like to order?\n"
m2: .asciiz "Do you have a discount coupon? Enter 1 for yes. (any other integer will indicate no discount)\n"
m3: .asciiz "Your total payment is "
m4: .asciiz "Invalid Number of T-Shirts."
.text
.globl main

main:
    #Prints dash line
    li $v0, 4   
    la $a0, dash
    syscall

    #Prints prompt m1
    la $a0, m1
    syscall

    #gets input for number of tshirts and stores it into $a0
    li $v0, 5
    syscall
    move $s0, $v0

    #Checks whether input number is negative or positive
    blt $zero, $s0, Positive
        #If negative prints message and returns
        li $v0, 4   
        la $a0, m4
        syscall
        jr $ra
    Positive:
        #If positive continues with checks
        li $a1, 100
        blt $a1, $s0, GreaterThanHundred
            #If less than hundred checks if greater than 50
            li $a1, 50
            bgt $a1, $s0, LessThanFifty
                #If less than 100 and greater than 50
                li $a1, 6
                mult $s0, $a1
                mflo $s0
                j Endif
            LessThanFifty:
                #If less than 100 and 50
                li $a1, 7
                mult $s0, $a1
                mflo $s0
                j Endif
        GreaterThanHundred:
            #If greater than 100
            li $a1, 5
            mult $s0, $a1
            mflo $s0
    Endif:
    #Prompts for discount
    li $v0, 4
    la $a0, m2
    syscall

    #Gets input
    li $v0, 5
    syscall
    move $a0, $v0

    #Checks if input equals 1
    li $a1, 1
    bne $a0, $a1, EndifTwo
        #If equal subtract 5 from $a0
        addi $s0, $s0, -5
    EndifTwo:

    #Print final price
    li $v0, 4
    la $a0, m3
    syscall
    move $a0, $s0
    li $v0, 1
    syscall
    li $v0, 4
    la $a0, newline
    syscall
    la $a0, dash
    syscall
    jr $ra