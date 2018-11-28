function par = parametros(h, alpha, da, de, freq, bw, vplat)  	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PURPOSE
%    Gerar os Parametros do Processador SAR
%
% INPUT
%    
% OUTPUT
%
% REVISION
%    Version |   Date     |   Author          | 
%    V1.0    | 10-09-2018 | Naiallen Carvalho |  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%		


    %% -Parametros do Meio=====================================================
    par.co = 299792458;             % [m/s] velocidade da luz

    %% -Parametros da Plataforma===============================================
    par.h = h;                      % [m] altura da platforma
    par.vplat = vplat;
    %% -Parametrosdo Sensor====================================================
    %--Parâmetros Eletônicos do Radar
    par.fp = freq;                  % [Hz] frequencia da portadora (banda X)
    par.lambda = par.co/par.fp;    	% [m] comprimento de onda
    par.bw = bw;                    % [Hz] bandwidth
    par.fs = bw*2;                % [Hz] frequencia de amostragem
    par.Ts = 1/par.fs;              % [s] Periodo de amostragem
     %--Tamanho do Sensor
    par.da = (par.lambda/4)*da;      %[m] comprimento efetivo da antena: dobro da resolução em azimute
    par.de = de;                     %[m] largura da antena (range)
    
    par.prf = (2*par.vplat/par.da);  %pulse repetition frequency
   
    %--Parametros da Imagem
    par.delta_R = par.co/(2*par.bw); % [m] resoluçãoem range
    par.delta_Az = 2*(par.da/2);  % [rad] resolução em azimute -> radar de abertura real ->depende do range
    
    %--Geometria 
    par.alpha = deg2rad(alpha);      % [rad] angulo de incidência
    par.sqt = deg2rad(0.0);          % [rad] squint angle (positivo apontando na direção ao voo)
    par.aba = par.lambda/par.da;     % [rad] abertura da antena em Azimute
    par.abr = par.lambda/par.de;     % [rad] abertura da imagem em elevação (slant range)

    %% -Parametros da cena=================================================
    par.theta = deg2rad(90 - alpha);         %[rad] média do angulo de depressão
    
    %RANGE ----------------------------------------------------------------
        %Near Range--
    par.R_grd_near = par.h*tan( par.alpha - (par.abr/2) );  %[m] Ground Range Near
    par.R_slt_near = par.h/cos( par.alpha - (par.abr/2) ); 
 
        %Far Range--
    par.R_grd_far = par.h*tan( par.alpha + (par.abr/2) );   %[m] Ground Range Far
    par.R_slt_far = par.h/cos( par.alpha + (par.abr/2) );             %[m] Slant Range Far
    
        %Comprimento do Swath--
    par.Sgrd = par.R_grd_far - par.R_grd_near;                      %[m] Ground Range Swath
    par.Sslt = par.R_slt_far - par.R_slt_near;%par.Sgrd*sin(par.theta);                             %[m] Slant Range Swath
    
        %Range Definitions--
    par.R_grd = par.R_grd_near + par.Sgrd/2; %par.h*tan( par.alpha );                   %[m] Ground Range
    par.R_slt = sqrt(par.R_grd^2 + par.h^2);                  %[m] Slant Range
    
    %AZIMUTE --------------------------------------------------------------
        %Near Range
    par.Dsn = par.R_slt_near*par.aba;                               %[m] Foot Print em Azimute no near range
        %Far Range
    par.Dsf = par.R_slt_far*par.aba;                                %[m] Foot Print em Azimute no far range

    par.Ds = par.R_slt*par.aba;                                     %[m] Foot Print em Azimute 
     
    %--Pixel Spacing
    par.pxr = (par.co/par.fs/2.0);     	% [m] pixel spacing em range 
    par.pxa = (par.vplat/par.prf);      % [m] pixel spacing em azimute 
    %Tamanho da Imagem (Bins)
    par.nap = 256;                      % [pixel] dimensão azimutal do plot
    par.nrp = 512;                      % [pixel] dimensão radial do plot

    %% -Parametros do Chirp====================================================
    par.tep = 2e-6;                                     % [s] duração do pulso
    par.chirp_rate = par.bw/par.tep;                    % [ ] chirp rate
    par.tau = -par.tep*1.1/2:1/par.fs:par.tep*1.1/2;    % [s] chirp time vector

    %% -Sinal de referencia====================================================
    par.ref_range = exp(1i*pi*par.chirp_rate*par.tau.^2).*rect_function(par.tau,0,par.tep).';   %Sinal Chrip no domínio do tempo
    
    %% -Definição do tamanho da Imagem em Range================================
    r_max = par.R_slt_far;      %range maximo 
    r_min = 0.9*par.R_slt_near;     %range mínimo
    par.t_fast_time = 2*r_min/par.co:par.Ts:2*r_max/par.co;       %fast time [Near Range : Range Resolution : Far Range]
    par.N_range = length(par.t_fast_time);                    %tamanho do vetor em range 
    par.vec_range = par.co*par.t_fast_time/2;                     %cena coberta

    %% -Definção do Tamanho da Imagem em Azimuth===============================
    par.tep_slow_time = (par.lambda/par.da)*(r_max/par.vplat); %tamanho do "pulso" em azimute
    par.t_slow_time = -par.tep_slow_time/2:1/par.prf:par.tep_slow_time/2;
    par.N_azimuth = length(par.t_slow_time);            %tamanho do vetor em azimute
    par.vec_azimuth = par.t_slow_time*par.vplat;          %cena coberta
    %------------------------------------------------
end