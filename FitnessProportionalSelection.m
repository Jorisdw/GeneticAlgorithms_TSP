function SelCh = FitnessProportionalSelection(Chrom,FitnV,GGAP)

    NtoSelect = floor(size(Chrom,1)*GGAP);
    [rows,cols] = size(Chrom);
    Temp = zeros(rows,cols+1);
    
    for i = 1:rows
       Temp(i,1) = FitnV(i);
       Temp(i,2:end) = Chrom(i,:);
        
    end
    
    Temp = sortrows(Temp,-1)
    
    SelCh = Temp(1:NtoSelect,2:end);
    SelCh = SelCh(randperm(NtoSelect),:);
end

