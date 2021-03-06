
%first direct search
%generate some random points
cn = 147;
preparenn;
max_runs = 5;

% globalResults = zeros(3,max_runs);
% 
% tic;
% for run=1:max_runs
% 
%     n = 1;
%     points = (rand(cn,n) - 0.5) * 2 * 10;
%     evals = zeros(1,n);
%     results = zeros(1,n);
%     xs= [];
%     bestval = inf;
%     bestindex = 0;
% 
%     options = psoptimset ( 'CompletePoll', 'off', 'Display', 'iter', 'TimeLimit', 120 );
% 
%     for i=1:n
%         [x, fval, exitflag, options] = patternsearch ( @trainnn, points(:,i), [], [],[],[], -1e5, 1e5, options  );
%         xs = [ xs x ];
%         results(1,i) = fval;
%         
%         if bestval > fval
%             bestval = fval;
%             bestindex = size(xs,2);
%         end
%         
%         evals(1,i) = options.iterations;
%     end
% 
% 
%     globalResults (1,run) = mean(evals);
%     globalResults (2,run) = mean(results(1,:));
% 
% end
% 
% save res.mat xs bestval
% 
% display ( ['elapsed time: ' num2str(toc) ]);
% display ( ['mean f-evals: ' num2str(mean(globalResults(1,:))) ]  );
% display ( ['average f-val: ' num2str(mean(globalResults(2,:))) ]  );
% display ( ['best f-val: ' num2str(bestval) ]  );
% display ( ['performance f-val: ' num2str( performnn(xs(:,bestindex))) ]  );
% 
% % plot best points
% figure;
% hist ( globalResults(1,:) );
% title ('Function evaluations for NN-fun - first sucessfull poll');
% pause;
% 
% 
% 
% %ga
%  
% pops = 50;
% j =1;
% results = zeros(2,length(pops));
% evals = zeros(1,length(pops));
% xs = [];
% bestval =Inf;
% bestindex =0;
% tic;
% 
% for i = pops
%     for runs=1:max_runs
%         options = gaoptimset ( 'PopInitRange', [-20;20], 'PopulationSize', i, 'TimeLimit', 120 );
%         [x, fval, reason, output, pop, score] = ga(@trainnn, cn, options);
%         results(:, j) = results(:, j) + [ i; fval ];
%         evals(j) = evals(j) + output.funccount;
%         
%         if  fval < bestval 
%             bestval = fval;
%             bestindex = size(xs,2)+1;
%         end
%         
%         xs = [ xs x' ];
%     end
%     j = j+1;
% end
% 
% results = results / max_runs;
% evals = evals / max_runs;
% 
% display ( ['elapsed time: ' num2str(toc) ]);
% display ( ['mean f-evals: ' num2str( mean(evals)) ]  );
% display ( ['average f-val: ' num2str( mean(results(2,:))) ]  );
% display ( ['best f-val: ' num2str(bestval) ]  );
% display ( ['performance f-val: ' num2str( performnn(xs(:,bestindex))) ]  );
% pause;


results = zeros(2,max_runs);
xs = [];
bestval =Inf;
bestindex =0;

tic;
for runs = 1:max_runs

    options = anneal();
    options.InitTemp = 5000;
    options.Verbosity =0;
    options.Generator =  @(x) (x+(randperm(length(x))==length(x))*randn);
    [x f evals] = anneal (@trainnn, (rand(1,cn)-0.5)*40, options);
    results(:, runs) = [ f; evals];
        
    if  f < bestval 
        bestval = f;
        bestindex = size(xs,2)+1;
    end
        
    xs = [ xs x' ];

end

display ( ['elapsed time: ' num2str(toc) ]);
display ( ['mean f-evals: ' num2str( mean(results(2,:))) ]  );
display ( ['average f-val: ' num2str( mean(results(1,:))) ]  );
display ( ['best f-val: ' num2str(bestval) ]  );
display ( ['performance f-val: ' num2str( performnn(xs(:,bestindex))) ]  );

