
clear all;

SNR = [0.1,0.5,1,2,5,10,20];  % SNR loop for plotting BER

% Request for number of bits
option = input('Choose the number of bits to transfer \n 1  >>> 10^3 \n 2  >>> 10^4\n 3 >>> 10^6\n ------ ');

% Request for prior probability for MAP estimate
px0=input('Enter the prior prob of x=0 ---> ');  


if option ==1
    N = 10^3;
elseif option ==2
    N = 10^4;
else
    N = 10^6;
end

tx = randi([0,1],N,1);  % Binary input vector
bpsk_tx= 2*tx - 1;      % BPSK modulation

for i = 1:length(SNR)
    
    NP = 10^(-0.1*SNR(i));  % Finding noise power from given SNR
    
    % AWGN noise
    noise = NP*randn(N,1);
    noise2 = NP*randn(N,1); % To create a rayleigh dxn
    
    sigma = sqrt(NP);
    
    % By making use of the fact that sqrt(X^2 + Y^2) is rayleigh dxn
    %   if X and Y are Gaussian
    h = 1/sqrt(2)*[sqrt(randn(N,1) + j*randn(N,1))];
    h =abs(h);
    %h = raylpdf(noise,0.5); 
    y_awgn = bpsk_tx + noise; 

    % Frequency flat
    y_flat = bpsk_tx.*h + noise;

    %--------  Receiver ----------------

    % Performing ML detection 


   y_ML_awgn_demod = ML_demod(y_awgn);
   y_ML_flat_demod = ML_demod(y_flat);
   ML_biterr_awgn(i) = bit_err(y_ML_awgn_demod,tx);
   ML_biterr_flat(i) = bit_err(y_ML_flat_demod,tx);

    % Performing MAP detection

   y_MAP_awgn_demod = MAP_demod(y_awgn,px0,NP);  %MAP demod function 
   y_MAP_flat_demod = MAP_demod(y_flat,px0,NP);
   MAP_biterr_awgn(i) = bit_err(y_MAP_awgn_demod,tx);
   MAP_biterr_flat(i) = bit_err(y_MAP_flat_demod,tx);         

end

%------- Display ------
disp('ML bit error : ')
disp(ML_biterr_awgn);
disp('MAP bit error : ')
disp(MAP_biterr_awgn);
disp('ML bit error : ')
disp(ML_biterr_flat);
disp('MAP bit error : ')
disp(MAP_biterr_flat);

%------  PLOT  --------
figure;
subplot(1,2,1);
plot(SNR,ML_biterr_awgn);
hold on;
plot(SNR,MAP_biterr_awgn,'--');
xlabel('SNR');
ylabel('BER')
title("ML vs MAP for AWGN channel for P(x =0)="+px0);
legend('ML','MAP');
hold off;
subplot(1,2,2);
plot(SNR,ML_biterr_flat);
hold on;
plot(SNR,MAP_biterr_flat,'--');
xlabel('SNR');
ylabel('BER')
title("ML vs MAP for freq flat channel for P(x =0)="+px0);
legend('ML','MAP');
hold off;


% ------- Maximum Likelihood demodulation  --------
function demod = ML_demod(bits)
    demod=[];
    for i = 1:size(bits)
       if bits(i)<0
           demod=[demod;0];
       else
           demod=[demod;1];
       end
    end
end

%--------   Maximum Aposteriori Probability Receiver  --------------------

function demod = MAP_demod(bits,px0,NP)
    demod=[];
    for i = 1:size(bits)
        if 4*bits(i) <= -2*NP*log((1-px0)/px0)
           demod=[demod;0];
        else
            demod = [demod;1];   
        end
    end
end


% Bit error rate calculation

function error = bit_err( y ,x)
    error =0;
    for i = 1:size(y)
        if y(i)~= x(i)
            error=error+1;
        end
    end
    error = error/size(y,1);
end




