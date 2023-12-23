n = input("Please input vertex number of the circuit graph:");
m = input("Please input edge number of the circuit graph:");

if n > m
    error("The graph can't form a circuit. Abort.");
end

A = zeros(n,m);
R = diag(Inf(1,m));

I_s = zeros(1,m);
U_s = zeros(1,m);

disp(newline);
disp("Input edge information:");
disp(newline);
disp("Format: <source> <destination> <opt_1> <val_1> ...");
disp("opt_i can be 'R', 'E' or 'I'.");
disp("Value after 'R', 'E' or 'I' declares the resistance value,");
disp("output of constant-voltage power and");
disp("output of constant-current power, respectively.");
disp(newline);
for i = 1:m
    disp("edge "+i+": ");
    str = input('','s');
    data = strsplit(str,' ');
    src = str2double(data{1}); dst = str2double(data{2});
    A(src,i) = 1; A(dst,i)=-1;

    args = size(data,2);
    for j = 3:2:args
        opt = data{j};
        val = str2double(data{j+1});
        if(opt == 'R')
            R(i, i) = val;
        elseif(opt == 'E')
            U_s(1,i) = val;
            if isinf(R(i,i))
                R(i,i) = 0;
            end
        elseif(opt == 'I')
            I_s(1,i) = val;
        else
            error("Illegal input format. Abort.");
        end
    end
end

A_apo = A;
R_apo = R;
U_s_apo = U_s;

for i = 1:size(A,2)
    if isinf(R(i,i))
        A_apo(:,i) = zeros(n,1);
        R_apo(i,i) = -1;
        U_s_apo(:,i) = 0;
    end
end

sol = gaussSolver( ...
    [R_apo       -transpose(A_apo); ...
     A           zeros(n,n);
     zeros(1,m)  1 zeros(1,n-1)], ...
    [transpose(U_s_apo) + R_apo * transpose(I_s); ...
     zeros(n+1,1)] ...
);

I = sol(1:m,:);
U_r = sol(m+1:m+n,:);

disp("I = " + newline);
disp(I);

disp("U = " + newline);
disp(U_r);