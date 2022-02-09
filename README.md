# Maximum-Likelihood-and-MAP-based-estimation
### AIM: To design an optimum Receiver using ML and MAP based estimation

- To design optimum receiver for performing signal detection.
- Considered 2 types of channels
    - y = x + n
    - y = x * h + n <br/>
      where
      n = AWGN noise<br/>
      h → Rayleigh dxn representing flat fading
- Implement BPSK modulation (Refer to my [repository](https://github.com/SarathMohanIITD/Simulation-of-BPSK-and-QPSK-with-varying-SNR) to see more about BPSK )
- On the receiver side perform 2 kinds of demodulation techniques 
    1. ML detection
    2. MAP detection
    
#### Look for [Assignment_4_Theory.pdf](https://github.com/SarathMohanIITD/Maximum-Likelihood-and-MAP-based-estimation/blob/main/Assignment_4_Theory.pdf) for the derivation of ML and MAP used in this experiment

## THEORY



## ALGORITHM USED

ALGORITHM
1. Initialized an array with a set of SNR values
2. Generated random input bits from the set {0,1}
3. The sample size has been taken as input from user
4. The prior probability of P(x=0) has been taken from user
5. Iterated over SNR values
    1. Simulated AWGN and Flat fading channels
    2. Decoded both in the receiver side using 2 detection schemes
        1. ML detection
        2. MAP detection
    3. Calculated BER for each SNR values
6. Finally, SNR vs BER has been plotted for both Flat fading and AWGN for both ML and MAP

## PLOTS


![image](https://user-images.githubusercontent.com/86975877/153172113-a7080bad-3473-4567-93e4-fa9d7d04ab06.png)


![image](https://user-images.githubusercontent.com/86975877/153172461-6e8abffc-38d1-4923-b8e4-de464b56a83f.png)


![image](https://user-images.githubusercontent.com/86975877/153172531-60382706-d2e1-41c0-aaa6-ad8d2e0852fe.png)

