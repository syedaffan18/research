function val = simnlb3_refined_p(e0, eps, e1)

%Rule: 
%String: 000
vector_0_0 = [
1/1 0/1
3/3 0/3
3/3 0/3
1/1 0/1
];

%Rule:  + 1
%String: 111
vector_0_0_ = [
0/1 1/1
0/3 3/3
0/3 3/3
0/1 1/1
];

%Rule: x0
%String: 011
vector_0_1 = [
1/1 0/1
2/3 1/3
1/3 2/3
0/1 1/1
];

%Rule: x0 + 1
%String: 100
vector_0_1_ = [
0/1 1/1
1/3 2/3
2/3 1/3
1/1 0/1
];

%Rule: x0 + x1
%String: 010
vector_0_2 = [
1/1 0/1
1/3 2/3
1/3 2/3
1/1 0/1
];

%Rule: x0 + x1 + 1
%String: 101
vector_0_2_ = [
0/1 1/1
2/3 1/3
2/3 1/3
0/1 1/1
];

%Rule: x0 + x1 + x2
%String: 010
vector_0_3 = [
1/1 0/1
0/3 3/3
3/3 0/3
0/1 1/1
];

%Rule: x0 + x1 + x2 + 1
%String: 101
vector_0_3_ = [
0/1 1/1
3/3 0/3
0/3 3/3
1/1 0/1
];

%Rule: 
%String: 000
vector_0_4 = [
1/1 0/1
3/3 0/3
3/3 0/3
1/1 0/1
];

%Rule:  + 1
%String: 111
vector_0_4_ = [
0/1 1/1
0/3 3/3
0/3 3/3
0/1 1/1
];

%Rule: x0
%String: 011
vector_0_5 = [
1/1 0/1
2/3 1/3
1/3 2/3
0/1 1/1
];

%Rule: x0 + 1
%String: 100
vector_0_5_ = [
0/1 1/1
1/3 2/3
2/3 1/3
1/1 0/1
];

%Rule: x0 + x1
%String: 010
vector_0_6 = [
1/1 0/1
1/3 2/3
1/3 2/3
1/1 0/1
];

%Rule: x0 + x1 + 1
%String: 101
vector_0_6_ = [
0/1 1/1
2/3 1/3
2/3 1/3
0/1 1/1
];

%Rule: x0 + x1 + x2
%String: 010
vector_0_7 = [
1/1 0/1
0/3 3/3
3/3 0/3
0/1 1/1
];

%Rule: x0 + x1 + x2 + 1
%String: 101
vector_0_7_ = [
0/1 1/1
3/3 0/3
0/3 3/3
1/1 0/1
];

%Rule: x0.x1
%String: 001
vector_1_0 = [
1/1 0/1
3/3 0/3
2/3 1/3
0/1 1/1
];

%Rule: x0.x1 + 1
%String: 110
vector_1_0_ = [
0/1 1/1
0/3 3/3
1/3 2/3
1/1 0/1
];

%Rule: x0.x1 + x2
%String: 001
vector_1_1 = [
1/1 0/1
2/3 1/3
0/3 3/3
1/1 0/1
];

%Rule: x0.x1 + x2 + 1
%String: 110
vector_1_1_ = [
0/1 1/1
1/3 2/3
3/3 0/3
0/1 1/1
];

%Rule: x0.x1 + x0 + x1
%String: 011
vector_1_2 = [
1/1 0/1
1/3 2/3
0/3 3/3
0/1 1/1
];

%Rule: x0.x1 + x0 + x1 + 1
%String: 100
vector_1_2_ = [
0/1 1/1
2/3 1/3
3/3 0/3
1/1 0/1
];

%Rule: x0.x1 + x0 + x1 + x2
%String: 011
vector_1_3 = [
1/1 0/1
0/3 3/3
2/3 1/3
1/1 0/1
];

%Rule: x0.x1 + x0 + x1 + x2 + 1
%String: 100
vector_1_3_ = [
0/1 1/1
3/3 0/3
1/3 2/3
0/1 1/1
];

%Rule: x0.x1 + x0.x2 + x1.x2
%String: 001
vector_2_0 = [
1/1 0/1
3/3 0/3
0/3 3/3
0/1 1/1
];

%Rule: x0.x1 + x0.x2 + x1.x2 + 1
%String: 110
vector_2_0_ = [
0/1 1/1
0/3 3/3
3/3 0/3
1/1 0/1
];

%Rule: x0.x1 + x0.x2 + x1.x2 + x0 + x1 + x2
%String: 011
vector_2_1 = [
1/1 0/1
0/3 3/3
0/3 3/3
1/1 0/1
];

%Rule: x0.x1 + x0.x2 + x1.x2 + x0 + x1 + x2 + 1
%String: 100
vector_2_1_ = [
0/1 1/1
3/3 0/3
3/3 0/3
0/1 1/1
];

%Rule: x0.x1.x2
%String: 000
vector_2_2 = [
1/1 0/1
3/3 0/3
3/3 0/3
0/1 1/1
];

%Rule: x0.x1.x2 + 1
%String: 111
vector_2_2_ = [
0/1 1/1
0/3 3/3
0/3 3/3
1/1 0/1
];

%Rule: x0.x1.x2 + x0 + x1 + x2
%String: 010
vector_2_3 = [
1/1 0/1
0/3 3/3
3/3 0/3
1/1 0/1
];

%Rule: x0.x1.x2 + x0 + x1 + x2 + 1
%String: 101
vector_2_3_ = [
0/1 1/1
3/3 0/3
0/3 3/3
0/1 1/1
];

%Rule: x0.x1 + x0.x2 + x1.x2 + x0.x1.x2
%String: 001
vector_2_4 = [
1/1 0/1
3/3 0/3
0/3 3/3
1/1 0/1
];

%Rule: x0.x1 + x0.x2 + x1.x2 + x0.x1.x2 + 1
%String: 110
vector_2_4_ = [
0/1 1/1
0/3 3/3
3/3 0/3
0/1 1/1
];

%Rule: x0.x1 + x0.x2 + x1.x2 + x0.x1.x2 + x0 + x1 + x2
%String: 011
vector_2_5 = [
1/1 0/1
0/3 3/3
0/3 3/3
0/1 1/1
];

%Rule: x0.x1 + x0.x2 + x1.x2 + x0.x1.x2 + x0 + x1 + x2 + 1
%String: 100
vector_2_5_ = [
0/1 1/1
3/3 0/3
3/3 0/3
1/1 0/1
];

n = 48;

cvx_begin sdp
	variable p(n)
%     variable e(4)
	val = 0;
    
    %Rule: x0.x1.x2
    box = [
    (1-e0)/1 (0+e0)/1
    (3-3*eps)/3 (0+3*eps)/3
    (3-3*eps)/3 (0+3*eps)/3
    (0+e1)/1 (1-e1)/1
    ];

%     8*eps == e(1) + 3*e(2) + 3*e(3) + e(4)   

	for i = 1:16
		val = val + 0*p(i);
	end

	for i = 17:24
		val = val + 1*p(i);
	end

	for i = 25:36
		val = val + 2*p(i);
	end

	strategy = zeros(4, 2);
	strategy = strategy + p(1) * vector_0_0;
	strategy = strategy + p(2) * vector_0_0_;
	strategy = strategy + p(3) * vector_0_1;
	strategy = strategy + p(4) * vector_0_1_;
	strategy = strategy + p(5) * vector_0_2;
	strategy = strategy + p(6) * vector_0_2_;
	strategy = strategy + p(7) * vector_0_3;
	strategy = strategy + p(8) * vector_0_3_;
% 	strategy = strategy + p(9) * vector_0_4;
% 	strategy = strategy + p(10) * vector_0_4_;
% 	strategy = strategy + p(11) * vector_0_5;
% 	strategy = strategy + p(12) * vector_0_5_;
% 	strategy = strategy + p(13) * vector_0_6;
% 	strategy = strategy + p(14) * vector_0_6_;
% 	strategy = strategy + p(15) * vector_0_7;
% 	strategy = strategy + p(16) * vector_0_7_;
	strategy = strategy + p(17) * vector_1_0;
	strategy = strategy + p(18) * vector_1_0_;
	strategy = strategy + p(19) * vector_1_1;
	strategy = strategy + p(20) * vector_1_1_;
	strategy = strategy + p(21) * vector_1_2;
	strategy = strategy + p(22) * vector_1_2_;
	strategy = strategy + p(23) * vector_1_3;
	strategy = strategy + p(24) * vector_1_3_;
	strategy = strategy + p(25) * vector_2_0;
	strategy = strategy + p(26) * vector_2_0_;
	strategy = strategy + p(27) * vector_2_1;
	strategy = strategy + p(28) * vector_2_1_;
	strategy = strategy + p(29) * vector_2_2;
	strategy = strategy + p(30) * vector_2_2_;
	strategy = strategy + p(31) * vector_2_3;
	strategy = strategy + p(32) * vector_2_3_;
	strategy = strategy + p(33) * vector_2_4;
	strategy = strategy + p(34) * vector_2_4_;
	strategy = strategy + p(35) * vector_2_5;
	strategy = strategy + p(36) * vector_2_5_;

	minimize(val)
	p >= 0;
	sum(p) == 1;
	box == strategy;

cvx_end
for i = 1:n
    if p(i) > 0.000001
        i, p(i)
    end
end
eps
box