
noise_var = 0.1;

option = input('Choose the number of bits to transfer \n 1  >>> 10^3 \n 2  >>> 10^4\n 3 >>> 10^6\n ------ ');
if option ==1
    N = 10^3;
elseif option ==2
        N=10^4;
else
    N = 10^6;
end

tx = randi([0,1],N,1); % Binary input vector

bpsk_tx= 2*tx - 1;      % BPSK modulation

noise = noise_var*randn(N,1);  % AWGN noise

% Adding AWGN noise
y_awgn = bpsk_tx + noise;

% Frequency flat
h = 4;
y_flat = bpsk_tx*h + noise;


%--------  Receiver ----------------

algo = input('Enter the demodulation scheme\n   1.  ML detection\n   2.   MAP detection   -----> ');


%  Performing ML detection 
if(algo ==1)

    y_awgn_demod = ML_demod(y_awgn);
    y_flat_demod = ML_demod(y_flat);

    biterr_awgn = bit_err(y_awgn_demod,bpsk_tx);
    biterr_flat = bit_err(y_flat_demod,bpsk_tx);
    disp(biterr_awgn);
    disp(biterr_flat);

else  
end
    

    

% Maximum Likelihood demodulation
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




