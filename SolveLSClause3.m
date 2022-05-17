

function [x_isdigit] = SolveLSClause3(N, A_all_isdigit, b_all_isdigit)
    A_train_isdigit = A_all_isdigit(1:N,:); 
    b_train_isdigit = b_all_isdigit(1:N); 
    x_isdigit=pinv(A_train_isdigit)*b_train_isdigit;  
end
