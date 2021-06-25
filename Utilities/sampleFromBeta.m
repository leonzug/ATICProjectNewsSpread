function [x] = sampleFromBeta(N, instruction_level)
inst = instruction_level;
pl = false;
if instruction_level <= 1 && instruction_level >= 0
    instruction_level = -(6*instruction_level-3);
    instruction_factor = 2^abs(instruction_level);
    parity_value = 1.3;

    if instruction_level > 0
        a =  parity_value;
        b =  instruction_factor*a;
    else
        b =  parity_value;
        a =  instruction_factor*b;

    end

    X = 0:0.01:1;
    y = betapdf(X,a,b);
    if pl
        figure
        plot(X,y,'Color','r','LineWidth',2)
        hold on
        %legend({"a = " + a + " b = " + b},'Location','NorthEast');
        %title("Critical Thinking Probability Distribution: " + "Instruction Level = " + inst)
        hold off
    end

    x = betarnd(a,b,N,1);
else
    disp("Error: instruction levels are between 0 and 1");
    x = NaN*ones(N,1);
end
end


