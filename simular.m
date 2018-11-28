%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PURPOSE
%    Simular Target com Radar de abertura Sintética
%
% INPUT
%    
% OUTPUT
%
% REVISION
%    Version |   Date     |   Author          | 
%    V1.0    | 10-09-2018 | Naiallen Carvalho |  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%		

%% -Simula a Imagem - Cria o dado Raw em range e azimute [fast time x slow time]
image = zeros(handles.par.N_range,handles.par.N_azimuth,2);
clear ref_range
ref_range(1,:) = cos(pi*handles.par.chirp_rate*handles.par.tau.^2).*rect_function(handles.par.tau,0,handles.par.tep).';   %Sinal Chrip no domínio do tempo
ref_range(2,:) = sin(pi*handles.par.chirp_rate*handles.par.tau.^2).*rect_function(handles.par.tau,0,handles.par.tep).';   %Sinal Chrip no domínio do tempo
% Sinal de referencia em range 
pad = (handles.par.N_range-length(handles.par.ref_range))/2;
if mod(handles.par.N_range-length(ref_range), 2) == 0 %even
    ref_range = ([zeros(2,pad), ref_range(:,:) , zeros(2,pad)]);
else %even
    pad = floor(pad);
    ref_range = ([zeros(2,pad), ref_range(:,:) , zeros(2,pad+1)]).';
end
ref_az = zeros(handles.par.N_range,handles.par.N_azimuth,2);


% handles.imraw = (1/sqrt(2))*10.^(handles.imraw/20);
R = zeros(handles.par.N_range, handles.par.N_azimuth);
az_A =  zeros(handles.par.N_range, handles.par.N_azimuth);

for pol = 1:2
    temp_data = zeros(handles.par.N_range, handles.par.N_azimuth,1);
    for ii = 1:100:handles.par.N_azimuth
        x = (ii*handles.par.pxa)-handles.par.Ds/2;
        y = ([1:handles.par.N_range]*handles.par.pxr)+handles.par.R_grd_near;
        R0 = sqrt(handles.par.h^2 + y.^2);
        
        for range = 1:handles.par.N_range;
            R(range, :) = sqrt(R0(range)^2 +(x-(handles.par.vplat*handles.par.t_slow_time)).^2);
            az_A(range, :) = sinc((handles.par.da/handles.par.lambda).*atan(handles.par.vplat*handles.par.t_slow_time/R0(range)));
        end
        
        if(pol == 1)
            az_phase = cos(-4*pi.*R./handles.par.lambda);
        else
            az_phase = sin(-4*pi.*R./handles.par.lambda);
        end
        for range = 1:50:handles.par.N_range
            for n = 1:handles.par.N_azimuth
                if(pol == 1)
                    r_phase = cos(pi*handles.par.chirp_rate*(handles.par.t_fast_time.'-2*R(range, n)/handles.par.co).^2);
                else
                    r_phase = sin(pi*handles.par.chirp_rate*(handles.par.t_fast_time.'-2*R(range, n)/handles.par.co).^2);
                end
                rectPulse = rect_function(handles.par.t_fast_time.',2*R(range, n)/handles.par.co, handles.par.tep);
                temp_data(:,n) = az_A(range, n)*az_phase(range, n)*r_phase.*rectPulse;
            end
             image(:,:,pol) = temp_data + image(:,:,pol);
        end
        
        
    end
    
    %------------------------------------------------
    clear temp_data
    
    %% -Processa a Imagem - Faz a compressao
    
    %Sinal de referencia em Azimute
    for k = 1:handles.par.N_range
        slow_time_k = (handles.par.lambda/handles.par.da)*(handles.par.vec_range(k)/handles.par.vplat);
        Tk = -slow_time_k/2:1/handles.par.prf:slow_time_k/2;
        handles.par.vec_azimuth_k = Tk*handles.par.vplat;
        R0 = handles.par.vec_range(k);
        Rk = R0.*(1 + (((handles.par.vplat).^2)*Tk.^2)/(2*R0.^2));
        
        if(pol == 1)
            temp_az = cos(-4*pi*Rk/handles.par.lambda);
        else
            temp_az = sin(-4*pi*Rk/handles.par.lambda);
        end
        
        pad = round((handles.par.N_azimuth-length(temp_az))/2)+1;
        ref_az(k,pad:pad+length(temp_az)-1, pol) = temp_az;
    end
end

%% HH
tmp = image(:,:,1);
if size(ref_range,1) > size(ref_range,2)
    range = ref_range(:,1);
else
    range = ref_range(1, :).';
end
RangeRef = fft(range);
Tmp = fft(tmp,[],1);
Image = bsxfun(@times,Tmp,conj(RangeRef));
improc = fftshift(ifft(Image,[],1),1);

Tmp = fft(improc,[],2);
azi = ref_az(:,:,1);
Ref_az = fft(azi,[], 2);
Image = bsxfun(@times,Tmp,conj(Ref_az));
improc = 1/sqrt(2)*fftshift(ifft(Image,[],2), 2);

cla(handles.imageHH);
improc = 20*log10(abs(improc))+ handles.imraw.';
if ( isinf(max(improc) ) )
    intmin = 0;
    intmax = 1;
else
    intmax = 130;% max(improc(:));
    intmin = 0;% min(improc(:))+50;
end

imagesc(handles.imageHH, handles.par.vec_azimuth, flip(handles.par.vec_range), improc, [intmin  intmax] );
colormap(handles.imageHH, 'bone')
axis(handles.imageHH, 'equal');


%% HV
tmp = image(:,:,2);

if size(ref_range,1) > size(ref_range,2)
    range = ref_range(:,1);
else
    range = ref_range(1, :).';
end

RangeRef = fft(range);
Tmp = fft(tmp,[],1);
Image = bsxfun(@times,Tmp,conj(RangeRef));
improc = fftshift(ifft(Image,[],1),1);

Tmp = fft(improc,[],2);
azi = ref_az(:,:,1);
Ref_az = fft(azi,[], 2);
Image = bsxfun(@times,Tmp,conj(Ref_az));
improc = 1/sqrt(2)*fftshift(ifft(Image,[],2), 2);

cla(handles.imageHV);
improc = 20*log10(abs(improc))+handles.imraw.';
if ( isinf(max(improc) ) )
    intmin = 0;
    intmax = 1;
else
    intmax = 130;% max(improc(:));
    intmin = 0;%min(improc(:))+50;
end

imagesc(handles.imageHV, handles.par.vec_azimuth, flip(handles.par.vec_range), improc, [intmin  intmax] );
colormap(handles.imageHV, 'bone')
axis(handles.imageHV, 'equal');

%% VV
tmp = image(:,:,2);

if size(ref_range,1) > size(ref_range,2)
    range = ref_range(:,2);
else
    range = ref_range(2, :).';
end

RangeRef = fft(range);
Tmp = fft(tmp,[],1);
Image = bsxfun(@times,Tmp,conj(RangeRef));
improc = fftshift(ifft(Image,[],1),1);

Tmp = fft(improc,[],2);
azi = ref_az(:,:,2);
Ref_az = fft(azi,[], 2);
Image = bsxfun(@times,Tmp,conj(Ref_az));
improc = 1/sqrt(2)*fftshift(ifft(Image,[],2), 2);

cla(handles.imageVV);
improc = 20*log10(abs(improc)) +handles.imraw.';
if ( isinf(max(improc) ) )
    intmin = 0;
    intmax = 1;
else
    intmax = 130;% max(improc(:));
    intmin = 0;%min(improc(:)+50);
end

imagesc(handles.imageVV, handles.par.vec_azimuth, (handles.par.vec_range), improc, [intmin  intmax] );
colormap(handles.imageVV, 'bone')
axis(handles.imageVV, 'equal');