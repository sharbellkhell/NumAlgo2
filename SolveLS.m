
function [A_train_isdigit, b_train_isdigit,A_test_isdigit, b_test_isdigit, x_isdigit] = SolveLS(N, size, A_all_isdigit, b_all_isdigit)
    A_train_isdigit = A_all_isdigit(1:N,:); 
    b_train_isdigit = b_all_isdigit(1:N); 
    x_isdigit=pinv(A_train_isdigit)*b_train_isdigit; 
    A_test_isdigit = A_all_isdigit(N+1:size*N,:); 
    b_test_isdigit = b_all_isdigit(N+1:size*N); 
end
