function [weightList, Hlist, coefList, Jacobians] = generalCTD(netWeights, netFuncs, J, BFlist, rank, samples)
%generalCTD general Constrained tensor based approach
%   Constrained tensor based approach for learning flexbile activation
%   functions. More general than the standard CTD in the sense that this
%   method allows for learning multiple layers with flexible activation
%   functions.

[~, m] = size(netFuncs);
[~, nbSamples] = size(samples);

weightList = cell(m+1,1);
Hlist = cell(m,1);
coefList = cell(m,1);
Jacobians = cell(m,1);
Jacobians{1} = J;

[weightList{2}, weightList{1}, Hlist{1}, coefList{1}] = ...
    CTD(J, BFlist{1}, rank, samples);

for i= 2:m
  % Compute Jacobian for next compression
  [~, nbInputs] = size(weightList{i});
  [nbOutputs, nbOutputsOriginal] = size(netWeights{i+1});
  [~, nbFunc] = size(netFuncs{i});

  currentFuncts = netFuncs{i};
  lastFuncts = netFuncs{i-1};
  
  J = zeros(nbOutputs, nbInputs, nbSamples);
  %samples = randn(nbInputs, nbSamples);
  newSamples = zeros(nbInputs, nbSamples);
   
  lastW0 = weightList{i-1};
  lastW1 = weightList{i};
  W0 = lastW1;
  W1 = netWeights{i+1};
  for j=1:nbSamples
    point = dlarray(samples(:,j));
    f = fLast(point, nbInputs, i-1);
    [~, J(:,:,j)] = dlfeval(@fInterm, dlarray(f));
    newSamples(:,j) = f;
  end
    
  Jacobians{i} = J;

  [weightList{i+1}, weightList{i}, Hlist{i}, coefList{i}] = ...
    CTD_spec(J, BFlist{i}, nbOutputsOriginal, newSamples, W0');
end

    function [f] = fLast(u, r, coefIndx)
        f = lastW0'*u;
        for p=1:r
            f(p) = applyBasisFunc(f(p), coefList{coefIndx}, BFlist{coefIndx});
        end
    end    

    function [f, grad] = fInterm(u)
        f = zeros(nbOutputs,1);
        grad = zeros(nbOutputs,nbInputs);

        interm = arrayfun(currentFuncts{1}, W0*u); %applyActivation(W0*u);
        for l=1:nbOutputs
            fcalc =  W1(l,:) * interm;

            f(l) = fcalc;
            grad(l,:) = dlgradient(fcalc, u);
        end
    end
    
    function [result] = applyActivation(u)
        result = zeros(nbFunc, 1);
        for k=1:nbFunc
            result(k) = currentFuncts{k}(u(k));
        end
    end

    function [result] = applyBasisFunc(input, coefs, bfs)
        result = 0;
        for n=1:size(coefs,2)
            [fval, ~] = dlfeval(bfs{n}, dlarray(input));
            result = result + coefs(n) * fval;
        end
    end
end




