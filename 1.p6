use v6;

sub newline () {
    say;
}

sub section ($num, $title) {
    say "$num: $title";
    newline;
}

sub example ($code) {
    say 'perl6' ~ input $code;
    say output eval $code;
    newline;
}

sub aplexample ($code, $result) {
    say 'apl' ~ input $code;
    say output $result;
    newline;
}

sub input ($code) {
    '> ' ~ $code;
}

sub output ($o) {
    '==> ' ~ result $o;
}

multi sub result ($s) {
    $s;
}

multi sub result (Bool $b) {
    $b.perl;
}

multi sub result (@l) {
    @l.map({result $_}).join(' ');
}

section 1, 'Important characteristics of notation.';

say 'Iverson lists a few additional key characteristics that are important for mathematical notations, although he specifies that it is not an exhaustive list:';
say ' * Ease of expressing constructs arising in problems.';
say ' * Suggestivity.';
say ' * Ability to subordinate detail.';
say ' * Economy.';
say ' * Amenability to formal proofs.';

say 'Throughout this chapter and the rest of the book, we will intermingle examples of APL code and their results, examples of Perl 6 code and their results, and explanatory text.';
newline;
say 'APL code examples will resemble the following:';
aplexample '⍳5', '1 2 3 4 5';
say 'The example APL code will be on the line beginning with "apl>", and its result will be on the line beginning with "===>". "apl>" is not part of the APL code, and neither is "==>" part of the result. They are included solely in order to distinguish between the input and output.';
say 'By the way, that was also actually our first code example. It showed us APL\'s "⍳" function which produces a vector of the first n positive integers, where n is its argument.';
newline;

say 'Perl 6 code examples will have a similar format, except that the code will be on a line beginning with "perl6>" instead of "apl>".';
example '1..5';
say 'This is the ".." operator, a more general counterpart to APL\'s "⍳". When used on two integers, ".." produces a list containing each integer between its first argument and its second argument, including the endpoints.';
newline;

say 'There is also a more specific Perl 6 operator which corresponds closely to "⍳", but it differs in that it begins at 0 instead of 1.';
example '^5';

say 'APL\'s "+/" produces the sum of its vector argument.';
aplexample '+/⍳5', '15';

say 'Perl 6\'s equivalent is the "[+]" operator.';
example '[+] 1..5';

section '1.1', 'Ease of Expressing Constructs Arising in Problems';

say 'In this section, Iverson discusses the first item of the preceding list: "Ease of Expressing Constructs Arising in Problems". A notation must make easy expressing not only the problem itself, but also concepts arising in "analysis, generalization, and specialization." As an example, he uses a closely-packed triangular crystal structure.';

say 'The number of items in each row of the crystal from the top are represented in APL by "⍳5".';
aplexample '⍳5', '1 2 3 4 5';
say 'The Perl 6 equivalent, again, is "1..5"';
example '1..5';

say 'Now he extends this to an analogous closely packed three-dimensional crystal structure. It is a tetrahedron with planes with bases of lengths, 2, 3, 4, and 5. The number of atoms in each plane from the top are the "partial sums" of "⍳5"(1, 1+2, 1+2+3, 1+2+3+4, 1+2+3+4+5). In APL, this is represented using the "sum scan" function "+\".';
aplexample '+\⍳5', '1 3 6 10 15';

say 'In Perl 6, one would use the "[\+]" operator.';
example '[\+] 1..5';

say 'To find the total number of atoms in the tetrahedron, we need only find the sum of the plane sizes, using, once again, the "+/" function.';
aplexample '+/+\⍳5', '35';

say 'Similarly, in Perl 6, we precede the "[\+]" operation with the "[+]" sum operator.';
example '[+] [\+] 1..5';

say 'Then he combines the figure representing ⍳5 with its reverse, producing a rectangle six units wide and five high.';
newline;

say '⍳6 is the first 6 positive integers, much like ⍳5.';
aplexample '⍳6', '1 2 3 4 5 6';

say '1..6 is the Perl 6 equivalent.';
example '1..6';

example '1..5';

aplexample '⌽⍳5', '5 4 3 2 1';
example '(1..5).reverse';

aplexample '(⍳5)+(⌽⍳5)', '6 6 6 6 6';
example '(1..5) >>+<< (1..5).reverse';

say 'In APL, the "⌽" function reverses a vector. In Perl, we instead use the ".reverse" method.';
say 'APL\'s "+" function works on both single values and arrays implicitly. Perl 6\'s "+" only works on scalars. In order to add the list to its reversed self, we must use a hyper-operator to extend "+" to operate on lists. The Perl 6 operator ">>+<<" adds two equal-length lists pairwise, producing a list of the sums.';

say 'Another way to express this pattern is as 5 repetitions of 6. In APL, this is "5⍴6".';
aplexample '5⍴6', '6 6 6 6 6';
say 'In Perl 6, this is "6 xx 5".';
example '6 xx 5';

aplexample '+/5⍴6', '30';
example '[+] 6 xx 5';

aplexample '6×5', '30';
example '6*5';

say 'APL represents the product of 6 and 5 with "6×5", while Perl uses the more easily-typed "6*5". Regardless, "6×5" is the same as "+/5⍴6", just as "6*5" is the same as "[+] 6 xx 5". As Iverson points out, this follows naturally from the definition of multiplication as repetition of addition.';
say 'From this, it can be inferred that "+/⍳n" is equivalent to "((n+1)×n)÷2". For another example:';
example '([+] 1..3) == (((3+1)*3)/2)';
say 'In Perl 6, instead of using the mathematical division sign "÷" for divison, we use "/". To test two numbers for equality, we use the "==" operator.';
newline;

section '1.2', 'Suggestivity';

say 'Iverson defines suggestivity in the first sentence of this section: "A notation will be said to be suggestive if the forms of the expressions arising in one set of problems suggest related expressions which find application in other problems." The remainder of the section deals with the relationships between different operations.';
aplexample '5⍴2', '2 2 2 2 2';
aplexample '×/5⍴2', '32';
example '2 xx 5';
example '[*] 2 xx 5';

say 'The APL code "×/m⍴n" is equivalent to the APL code "n*m", where "*" is the power function. Perl uses "**" for exponentiation. Just as multiplication is equivalent to repeated addition, exponentiation is equivalent to repeated multiplication.';

say 'What about partial sums and products?';
aplexample '×\5⍴2', '2 4 8 16 32';
example '[\*] 2 xx 5';

aplexample '2*⍳5', '2 4 8 16 32';
example '2 <<**<< (1..5)';

say 'Note that in this last case, one pair of angle brackets in our hyper operator points in the opposite direction that in our previous examples. This is because the ">> <<" form of the hyper operator is for equal-length lists. If one of the pairs of brackets points toward the operand instead of the operator, that operand will be extended by repetition as much as is necessary to become as long as the other operand. If both pairs of brackets point to their operands, whichever operand is shorter will be extended.';
newline;

say 'The numbers "+\⍳n" or "[\+] 1..n" are called "triangular numbers" because, as the crystal structure from Section 1.1 demonstrated, they can be represented with a triangle. More generally, the "figurate numbers" are generated by repeatedly applying "+\" to "⍳n".';

aplexample '5⍴1', '1 1 1 1 1';
example '1 xx 5';
aplexample '+\5⍴1', '1 2 3 4 5';
example '[\+] 1 xx 5';
aplexample '+\+\5⍴1', '1 3 6 10 15';
example '[\+] [[\+] 1 xx 5] # The extra "[]" brackets around the first scan is due to a Rakudo bug.';
aplexample '+\+\+\5⍴1', '1 4 10 20 35';
example '[\+] [[\+] [[\+] 1 xx 5]] # Again, extra brackets to work-around a Rakudo bug.';

say 'With multiplication instead of addition you generate the factorials.';
aplexample '⍳5', '1 2 3 4 5';
example '1..5';
aplexample '×/⍳5', '120';
example '[*] 1..5';
aplexample '×\⍳5', '1 2 6 24 120';
example '[\*] 1..5';
aplexample '!5', '120';
aplexample '!⍳5', '1 2 6 24 120';

say 'Perl 6 doesn\'t have a built-in factorial operator or function, although it is trivial to define one using "[*] 1..n".';
newline;

say 'Another way to find the product of a vector of positive numbers is to take the logarithms of each element, sum them, and then apply the exponential function to each element. In APL, "⍟" is the natural logarithm function, and "*" with a single argument is the exponetial function.';
say 'Therefore, "×/v" is equivalent to "*+/⍟v", or, in Perl 6: "[*] @v" is equivalent to "([+] @v>>.log).exp", although floating point error may make this only approximately true.';
example '5.log';
example '5.exp';
example '5.exp.log';
example '(1..5)>>.log';
say '"">>.log" is a hyper method-call. It calls the method on every element of the list and produces a list of the results.';
example '([+] (1..5)>>.log).exp';

say 'Iverson goes on to mention a few other similar dualities, including DeMorgan\'s laws, relational functions, and maximum and minimum.';

say 'In APL, "∧/b" is equivalent to "~∨/~b" where "∧" is the and function, 
"∨" is the or function and "~" is logical negation, "∧/b" is equivalent to "~∨/~b".';
say 'In Perl 6, "∧" is instead "&&". "&&" short-circuits if the left operand is false, not evaluating the right side because its result will not affect the result of the "&&" function. "∨" is instead "||", which also short-circuits if the second operand will not affect the result. However, "||" short-circuits only if the first operand is true. The "!" prefix operator performs logical negation in Perl 6.';

example 'True && True';
example 'True && False';
example 'False && True';
example 'False && False';
example 'False && say("This won\'t happen!")';

example 'True || True';
example 'True || False';
example 'False || True';
example 'False || False';
example 'True || say("This won\'t happen, either!")';

say 'The "say" function used in the previous examples, outputs the string given to it followed by a newline. It was not run in either case due to the short-circuiting behavior of && and ||.';
newline;

example '!<< (True, False, True)';
say '"!<<" is the hyper-operator form of the prefix "!" logical negation operator. It is analogous to APL\'s "~" when applied to a list.';
example '[||] !<<(True, False, True)';
example '![||] !<<(True, False, True)';
example '[&&] True, False, True';

say 'As the above examples demonstrate, "[&&] @l" is indeed equivalent to "![||] !<<(@l)".';
say 'As an aside that is not particularly related to this specific example, nor to Notation as a Tool of Thought, when building complex expressions using hyper-operators and other list-related meta-operators, it can be very helpful to build the final expression piecewise, starting with what you have originally, and adding transformations on it step-by-step until you have the desired result. The above examples demonstrating the Perl 6 version of "∧/b" is equivalent to "~∨/~b" is an example of this. I started with the list "b", added an operation to negate each element, added an operation to reduce the or operator over the list, and and finally negated the result. In addition, when writing more complex list manipulations, it can be helpful to separate operations using variables, add more parentheses to more explicitly specify the order of operations, and separate common operations into their own functions.';
newline;

say 'Another example Iverson gives is boolean equality and inequality.';
say 'In APL, "≠/b" is equivalent to "~=/~b", and "=/b" is equivalent to "~≠/~b", if "b" is a vector of booleans.';
say 'In Perl 6, "[!=] @b" is equivalent to "![==] !<<@b", and "[==] @b" is equivalent to "![!=] !<<@b". "!=" in Perl corresponds to "≠" in APL. "==" corresponds to APL\'s "=". Perl 6\'s "!=" is actually an alias for "!==", which is formed by applying the "!" meta-operator to the "==" operator. Any relational operator returning a boolean value can be negated with the "!" meta-operator.';

example '[!=] True, False, True';
example '![==] !<<(True, False, True)';

say 'Finally, we can relate the maximum and minimum functions, denoted in APL as "⌈" and "⌊" and in Perl 6 as "max" and "min" as follows:';
say 'The reduction of the maximum function over a list("⌈/v" in APL and "[max] @v" in Perl 6) is equivalent to the negations of the reduction of the minimum function over the negations of the list("-⌊/-v" in APL and "-[min] -<<@v" in Perl 6).';

example '(37, 5, -38, 9, 23)';
example '[max] (37, 5, -38, 9, 23)';
example '-[min] -<<(37, 5, -38, 9, 23)';

say 'Iverson also remarks that scan("f\") may replace reduction ("f/") in any of these dualities.';

say 'As an example, let us consider the duality between maximum and minimum.';
example '(3, 5, -38, 9, 23, 7, 37)';
example '[\max] (3, 5, -38, 9, 23, 7, 37)';
example '-<<[\min] -<<(3, 5, -38, 9, 23, 7, 37)';
say 'Since "scan" produces a list instead of a scalar, we must use a hyper-operator on the final negation.';
newline;

section '1.3', 'Subordination of detail';

say 'Iverson tells us that brevity is achieved by subordinating detail and cites Cajori citing Babbage describing how the brevity allowed by, for example, algebraic notation makes it easier to reason about the subject.';

say 'He lists three techniques for subordinating detail: arrays, naming functions and variables, and using operators. Note that the word "operator" as he uses it is distinct from the way in which the word "operator" is used in Perl 6. Perl 6 "operators" are just another kind of function. The difference is essentially syntactic. Iverson\'s "operators", such as the "scan" and "reduction" operators "\" and "/" from APL we\'ve used repeatedly so far, operate on functions to produce other functions. This is analogous to Perl 6 "meta-operators" like "[ ]", "[\ ]", "<<", ">>", "!", etc.';
newline;

say 'APL functions extend automatically to functions of higher dimension or rank. It is possible to specify the axis of an array on which a function operates. "⌽[1]m" operates along the first axis of m, reversing each column. By defualt, functions operate on the last axis. Reduction and scan can also be performed on the first axis instead of the last via "⌿" and "⍀". Perl 6 does not have a corresponding operator or function built-in.';

say 'Concerning naming things, Iverson distinguishes between constant, very general names(such as "144") and "ad hoc names" that are given to more narrowly-useful values. In APL, the "←" function is used to name things. In Perl 6, the "=" operator serves a corresponding purpose.';

aplexample "crate ← 144\n"
  ~ "layer ← crate÷8\n"
  ~ "row ← layer÷3\n"
  ~ "row",
  '6';
example 'my $crate = 144;' ~ "\n"
  ~ 'my $layer = $crate / 8;' ~ "\n"
  ~ 'my $row = $layer / 3;' ~ "n";

say 'You might be thinking "What\'s with all this \'my\' stuff in the Perl 6 example?" Perl 6 uses "my" as a variable declarator. Perl 6 requires variable declarations(although scripts beginning with a bare "v6" may relax this restriction). The "my" declarator specifies that the variable should be lexically scoped. In other words, the variable will only be visible in scopes that are enclosed within the scope in which it is declared. By contrast, APL uses dynamic scope, meaning that a variable definition in a scope is visible in any functions called from that scope. This doesn\'t really matter at the scale at which we are working right now, but lexical scoping can greatly simplify reasoning about and debugging larger programs.';
say 'The presence of "$" in front of all of the variables in the Perl 6 code may also have you wondering. Perl 6 uses "sigils" to specify certain properties of the variables. A variable with a "$" sigil refers to one thing of any kind. A variable with a "@" sigil refers to an array of things. A variable with a "%" sigil refers to a hash. A variable with a "&" sigil refers to a function. A variable with a "::" sigil is a type. You\'ll probably usually only need to use "$", "@", "%", and occasionally "&". I\'m slightly simplifying in terms of what types of values a variable with each sigil can refer to, but it is essentially accurate, and if you want to know more specifically what constraints sigils place on variable values, read the "Names and Variables" section of S02 of the Perl 6 spec.';
newline;

say 'Iverson gives two more examples of constant names: the "," and "⊤" functions. The "," function catenates its arguments. The "⊤" function encodes its second argument in the base denoted by its first.';

aplexample '(⍳5),(⌽⍳5)', '1 2 3 4 5 5 4 3 2 1';
say 'The Perl 6 equivalent of "a,b" is "(@a, @b)".';
example '(1..5, (1..5).reverse)';
