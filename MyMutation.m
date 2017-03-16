% Insert Mutation
function NewChromosome = MyMutation( OldChromosome , N )

    cols = size(OldChromosome,2);
    NewChromosome = zeros(size(OldChromosome));
    
    t1 = floor(rand*(cols-1))+1;
    t2 = floor(rand*(cols-1))+1;
    rand1 = max(t1,t2);
    rand2 = min(t1,t2);
    
    NewChromosome(1:rand2) = OldChromosome(1:rand2);
    NewChromosome(rand2+1) = OldChromosome(rand1);
    NewChromosome(rand2+2:rand1) = OldChromosome(rand2+1:rand1-1);
    NewChromosome(rand1+1:cols) = OldChromosome(rand1+1:cols);
    
end

