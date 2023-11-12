disp("************************** NTT *************************")
disp("************ Multiplication Over Zq/<X^n-1> ************")
readLinesFromFile("NTT_mults.txt")
disp(" ")
disp("******************** NTT NEGACYCLIC ********************")
disp("************ Multiplication Over Zq/<X^n+1> ************")
readLinesFromFile("NTT_mults_negacyclic.txt")

%%
function [resultado_minus1, resultado_plus1] = perform_operations(input_matrix, modulo)
    % Invert the input arrays
    aa = fliplr(input_matrix(1, :));
    bb = fliplr(input_matrix(2, :));
    
    % Calculate the length of the input arrays
    N = max(length(aa), length(bb));
    
    % Generate the deconvolution coefficients for x^N - 1
    deconv_coeffs = [1, zeros(1, N - 1), -1];
    
    % Convolution
    cc = conv(aa, bb);
    
    % Deconvolution with x^N - 1
    [qq, rr] = deconv(cc, deconv_coeffs);
    resultado_minus1 = mod(rr, modulo);
    resultado_minus1 = fliplr(resultado_minus1);
    resultado_minus1 = resultado_minus1(:,1:N);

    % Generate the deconvolution coefficients for x^N + 1
    deconv_coeffs_plus1 = [1, zeros(1, N - 1), 1];
    
    % Deconvolution with x^N + 1
    [qq2, rr2] = deconv(cc, deconv_coeffs_plus1);
    resultado_plus1 = mod(rr2, modulo);
    resultado_plus1 = fliplr(resultado_plus1);
    resultado_plus1 = resultado_plus1(:,1:N);
end


%%
function readLinesFromFile(filename)
    LogicalStr = {'false', 'true'};
    
    fileID = fopen(filename, 'r');

    lineIndex = 1;

    line = fgetl(fileID);
    while ischar(line)
        
        if mod(lineIndex,3)==1
            input = str2num(line);
        elseif mod(lineIndex, 3)==2
            modulo = str2double(line);
        else
            output = str2num(line);

            [resultado_minus1, resultado_plus1] = perform_operations(input, modulo);

            resultado_igual = 0;
            if contains(filename, "negacyclic")
                resultado_igual = isequal(output, resultado_plus1);
            else
                resultado_igual = isequal(output, resultado_minus1);
            end

            fprintf("Los resultados tras multiplicación de polinomios de grados %i son iguales: %s\n", ...
                length(input(1,:)), LogicalStr{resultado_igual + 1})

        end
        lineIndex = lineIndex + 1;
        
        line = fgetl(fileID);
    end
    
    fclose(fileID);

end
