function SelCh = TournamentSelection(Chrom,FitnV,GGAP)

    [rows,cols] = size(Chrom);
    tournamentsize = 3;
    NtoSelect = floor(rows*GGAP);
    Temp = zeros(rows,cols+1);
    for i = 1:rows
        Temp(i,1) = FitnV(i);
        Temp(i,2:end) = Chrom(i,:);
    end
    SelCh = zeros(NtoSelect,cols);
    for i=1:NtoSelect    
        tournament = rand_int(tournamentsize,1,[1,rows]); % With replacement
        % Without replacement with permutation and taking the first cols
        T = Temp(tournament,:);
        T = sortrows(T,-1);
        SelCh(i,:) = T(1,2:end);
    end
end

