%
% ObjVal = tspfun(Phen, Dist)
% Implementation of the TSP fitness function
%	Phen contains the phenocode of the matrix coded in adjacency
%	representation
%	Dist is the matrix with precalculated distances between each pair of cities
%	ObjVal is a vector with the fitness values for each candidate tour (=each row of Phen)
%

function ObjVal = tspfun(Phen, Dist);
    % Phen(:,1) = 1e kolom van alle rijen
    ObjVal = zeros(size(Phen,1),1);
	Phen
    for t=1:size(Phen,1)
        temp = 0;
    	for i = 1:(size(Phen,2)-1)
            t1 = Phen(t,i);
            t2 = Phen(t,i+1);
            temp = temp + Dist(t1,t2);
        end
        temp = temp + Dist(Phen(t,size(Phen,2)),Phen(t,1));
        ObjVal(t)=temp;
	end


% End of function

