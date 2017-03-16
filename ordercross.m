function Offspring = ordercross(Parents,rand1,rand2)

    cols=size(Parents,2);
	Offspring=zeros(1,cols);
    
    Offspring(1,rand2:rand1) = Parents(1,rand2:rand1);
    j=1;
    for i=1:cols
        nextIndexi = i+rand1;
        if nextIndexi > cols
            nextIndexi = nextIndexi - cols;
        end
        nextIndexj = j+rand1;
        if nextIndexj > cols
            nextIndexj = nextIndexj - cols;
        end
        if ismember(Parents(2,nextIndexi),Offspring)==0
            Offspring(nextIndexj) = Parents(2,nextIndexi);
            j = j + 1;
        end
    end
    
    if ismember(Offspring,0)
        rand1
        rand2
        Offspring
    end
end

