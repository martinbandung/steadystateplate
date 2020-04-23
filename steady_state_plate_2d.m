clear all
tkiri=0;
tkanan=100;
tatas=0;
tbawah=100;

statpusat=false;
tpusat=100;

bataskanan=10;
batasatas=50;

nx=100;
ny=100;
x=linspace(0,bataskanan,nx);
y=linspace(0,batasatas,ny);
dx=bataskanan/nx;
dy=batasatas/ny;

tlama=zeros(nx,ny);
maxerror=1e-5;
counterror=10;

%inisialisasi syarat batas di pinggir
for i=1:nx
    tlama(i,1)=tatas;
    tlama(i,end)=tbawah;
    tlama(1,i)=tkiri;
    tlama(end,i)=tkanan;
end
if statpusat
    tlama(nx/2,ny/2)=tpusat;
end
tbaru=tlama;

%cek konvergensi
while counterror>0
    counterror=0;
    %hitung tbaru
    for i=2:nx-1
        for j=2:ny-1
            tbaru(i,j)=(dx^2*(tlama(i+1,j)+tlama(i-1,j))+dy^2*(tlama(i,j+1)+tlama(i,j-1)))/(2*(dx^2+dy^2));
            error=tbaru(i,j)-tlama(i,j);
            if error>maxerror
                counterror=counterror+1;
            end
        end
    end
    if statpusat
        tbaru(nx/2,ny/2)=tpusat;
    end
    %update
    tlama=tbaru;
end

colormap(jet);
imagesc(x,y,tbaru');  colorbar;
%axis([0 bataskanan 0 batasatas]);
%axis.YDir = 'reverse';
