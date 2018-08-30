clc
close all
clear all

%% 
dx = 1/4;                                       % State discretization

K_lb = 2; K_ub = 4;                             % Constraint set, K = (2, 4)

xs = K_lb - 1 : dx : K_ub + 1;                  % Discretized states

ls = [ 0.95, 1/2, 0.05 ];                       % Discretized confidence levels

%% 
% x=1;

g = @(x) abs(x-3)-1;
z1 = @(x) max( [g(x(1)); g(x(2)); g(x(3))] );
% z2 = @(x) exp(g(x(1)) + exp(g(x(2)) + exp(g(x(3)) ;

%% 
alpha = 0.9;
policy_u0 = [-1;1];
policy_u1 = [-1;1];

possible_w0 = [-1;0;1];
possible_w1 = [-1;0;1];

for alphaindex = 1:size(ls,2)
    alpha = ls(alphaindex);
    for xindex = 1:size(xs,2)
        x = xs(xindex);

        for ii = 1:size(policy_u0,1)
        for jj = 1:size(policy_u1,1)
            for kk = 1:size(possible_w0,1)
            for ll = 1:size(possible_w1,1)
                z{ii,jj}(kk,ll) = z1([x;x+policy_u0(ii)+possible_w0(kk);x+policy_u0(ii)+possible_w0(kk)+policy_u1(jj)+possible_w1(ll)]);
        %         z{ii,jj}(kk,ll) = z2([x;x+policy_u0(ii)+possible_w0(kk);x+policy_u0(ii)+possible_w0(kk)+policy_u1(jj)+possible_w1(ll)]);
            end
            end
            % CVaR{1}{ii,jj} = min_c c+1/alpha* sum( max( z{ii,jj}(kk,ll) - c,0 ) )*1/9

        cvx_begin

            variables c

            cost =c;
            for kk = 1:size(possible_w0,1)
            for ll = 1:size(possible_w1,1)
                cost = cost + 1/alpha * max( z{ii,jj}(kk,ll) - c,0 ) *1/9;
            end
            end

            minimize( cost  )


        cvx_end

            Opt_C{ii,jj} = c;
            Opt_Value{ii,jj} = cost;
        end
        end
        Matrix_Opt_Value = cell2mat(Opt_Value);

        [tmp_Opt_Value1, I1] = max(Matrix_Opt_Value);
        [tmp_Opt_Value2, I2] = max(tmp_Opt_Value1);

        Opt_Index_u0u1{alphaindex}(:,xindex) = [I1(I2); I2];
        Opt_Cost{alphaindex}(xindex) = tmp_Opt_Value2;
    end
end







