function NewChrom = MyCrossover(OldChrom, XOVR);

if nargin < 2, XOVR = NaN; end
   
[rows,cols]=size(OldChrom);
   
   maxrows=rows;
   if rem(rows,2)~=0
	   maxrows=maxrows-1;
   end
   
   for row=1:2:maxrows
	
     	% crossover of the two chromosomes
   	% results in 2 offsprings
	t1 = floor(rand*(cols-1))+1;
    t2 = floor(rand*(cols-1))+1;
    rand1 = max(t1,t2);
    rand2 = min(t1,t2);
    if rand<XOVR			% recombine with a given probability
		NewChrom(row,:) =ordercross([OldChrom(row,:);OldChrom(row+1,:)],rand1,rand2);
		NewChrom(row+1,:)=ordercross([OldChrom(row+1,:);OldChrom(row,:)],rand1,rand2);
	else
		NewChrom(row,:)=OldChrom(row,:);
		NewChrom(row+1,:)=OldChrom(row+1,:);
	end
   end

   if rem(rows,2)~=0
	   NewChrom(rows,:)=OldChrom(rows,:);
   end

   

% End of function
