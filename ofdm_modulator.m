function [modulated_symbol] = ofdm_modulator(qpsk_symbols, delta_Rs, T_CP, C, N_subcarrier)
    N_RS = floor((N_subcarrier - 1) / delta_Rs) + 1;
    N_data = N_subcarrier - N_RS;

    if length(qpsk_symbols) < N_data
        qpsk_symbols = [qpsk_symbols, zeros(1, N_data - length(qpsk_symbols))];
    elseif length(qpsk_symbols) > N_data
        error(['Too many data symbols for the given number of subcarriers. ', ...
                   'Available subcarriers for data: ', num2str(N_data), ...
                   '. Provided data length: ', num2str(length(qpsk_symbols))]);
    end

    rs_indices = 1:delta_Rs:N_subcarrier;

    subcarriers = zeros(1, N_subcarrier);

    rs_signal = 0.707 + 1j * 0.707;
    subcarriers(rs_indices) = rs_signal;

    all_indices = 1:N_subcarrier;
    data_indices = setdiff(all_indices, rs_indices);

    subcarriers(data_indices) = qpsk_symbols;

    N_0 = round(C * (N_subcarrier / (1 - C)));
    left_zeros = zeros(1, N_0);
    right_zeros = zeros(1, N_0);
    full_subcarriers = [left_zeros, subcarriers, right_zeros];

    ofdm_temp = ifft(full_subcarriers);

    if T_CP > length(ofdm_temp)
        error('Cyclic prefix length exceeds OFDM symbol length');
    end

    cp = ofdm_temp(end - T_CP + 1:end);
    modulated_symbol = [cp, ofdm_temp];
end
