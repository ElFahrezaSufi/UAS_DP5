program Sistem_Nilai_Mahasiswa;
uses crt;

type
    { Record untuk menyimpan data mahasiswa }
    data = record
        nama: string;
        nim: string;
        jurusan: string;
        semester: integer;
        nilai: array[1..10] of real;
        sks: array[1..10] of integer;
        gradeHuruf: array[1..10] of char;
        gradeAngka: array[1..10] of integer;
        ips: real;
    end;
    arrMahasiswa = array[1..50] of data;  { Array untuk menyimpan data banyak mahasiswa }

var
    mahasiswa: arrMahasiswa;
    jumlahMahasiswa, n, i, j: integer;
    pilihan: char;

{ Prosedur untuk menentukan grade berdasarkan nilai }
procedure HitungGrade(nilai: real; var gradeHuruf: char; var gradeAngka: integer);
begin
    if nilai >= 80 then
        begin
            gradeHuruf := 'A';
            gradeAngka := 4;
        end
    else if nilai >= 70 then
        begin
            gradeHuruf := 'B';
            gradeAngka := 3;
        end
    else if nilai >= 60 then
        begin
            gradeHuruf := 'C';
            gradeAngka := 2;
        end
    else if nilai >= 50 then
        begin
            gradeHuruf := 'D';
            gradeAngka := 1;
        end
    else
        begin
            gradeHuruf := 'E';
            gradeAngka := 0;
        end;
end;

{ Fungsi untuk menghitung IPS (Indeks Prestasi Semester) }
function HitungIPS(gradeAngka: array of integer; sks: array of integer; jumlahMatKul: integer): real;
var
    i: integer;
    totalSKS, totalNilai: real;

begin
    totalSKS := 0;
    totalNilai := 0;
    for i := 1 to jumlahMatKul do
        begin
            totalNilai := totalNilai + (gradeAngka[i] * sks[i]);
            totalSKS := totalSKS + sks[i];
        end;

    if totalSKS = 0 then { Validasi total SKS }
        begin
            HitungIPS := 0;
        end
    else
        begin
            HitungIPS := totalNilai / totalSKS;
        end;
end;

{ Prosedur untuk menambah data mahasiswa }
procedure TambahMahasiswa(var mahasiswa: arrMahasiswa; var jumlahMahasiswa: integer);
begin
    clrscr;
    jumlahMahasiswa := jumlahMahasiswa + 1;
    with mahasiswa[jumlahMahasiswa] do
        begin
            writeln('Masukkan Data Mahasiswa ke-',jumlahMahasiswa,':');
            write('Masukkan Nama Mahasiswa: ');
            readln(nama);
            write('Masukkan NIM Mahasiswa: ');
            readln(nim);
            write('Masukkan Jurusan Mahasiswa: ');
            readln(jurusan);
            write('Masukkan Semester Mahasiswa: ');
            readln(semester);

            writeln('Ada berapa jumlah mata kuliah yang dijalani?');
            write('Jawab: ');
            readln(n);
            for i := 1 to n do
                begin
                    repeat
                        write('Nilai Mata Kuliah ke-', i, ': ');
                        readln(nilai[i]);
                        if (nilai[i] < 0) or (nilai[i] > 100) then
                            begin
                                writeln('Nilai tidak valid! Masukkan nilai antara 0 - 100.');
                            end;
                    until (nilai[i] >= 0) and (nilai[i] <= 100);

                    write('Masukkan jumlah SKS Mata Kuliah ke-', i, ': ');
                    readln(sks[i]);
                    HitungGrade(nilai[i], gradeHuruf[i], gradeAngka[i]);
                end;
            ips := HitungIPS(gradeAngka, sks, n);
        end;
    writeln;
    writeln('Data mahasiswa berhasil ditambahkan!');
end;

{ Prosedur untuk menampilkan data semua mahasiswa }
procedure TampilkanMahasiswa(var mahasiswa: arrMahasiswa; jumlahMahasiswa: integer);
begin
    clrscr;
    if jumlahMahasiswa = 0 then
        begin
            writeln('Tidak ada data mahasiswa.');
        end
    else
        begin
            for j := 1 to jumlahMahasiswa do
                begin
                    writeln('Data Mahasiswa ke-', j, ':');
                    with mahasiswa[j] do
                        begin
                            writeln('Nama: ', nama);
                            writeln('NIM: ', nim);
                            writeln('Jurusan: ', jurusan);
                            writeln('Semester: ', semester);
                            writeln('IP Semester ', semester,': ', ips:0:2);

                            writeln('Rincian Penilaian:');
                            for i := 1 to n do
                                begin
                                    writeln('Mata Kuliah ke-', i,' | Nilai: ', nilai[i]:0:2, ' | SKS: ', sks[i], ' | Grade Huruf: ', gradeHuruf[i], ' | Grade Angka: ', gradeAngka[i]);
                                end;
                        end;
                    writeln;
                end;
        end;
end;

{ Program utama }
begin
    clrscr;
    writeln('Program Sistem Nilai Mahasiswa!');
    jumlahMahasiswa := 0;
    repeat
        writeln('Menu:');
        writeln('1. Tambah Mahasiswa');
        writeln('2. Tampilkan Mahasiswa');
        writeln('3. Keluar');

        write('Pilih menu (1/2/3): ');
        readln(pilihan);
        writeln;
        case pilihan of
            '1': TambahMahasiswa(mahasiswa, jumlahMahasiswa);
            '2': TampilkanMahasiswa(mahasiswa, jumlahMahasiswa);
            '3': writeln('Terima kasih! Program selesai.');
        else
            begin
                writeln('Pilihan tidak valid.');
            end;
        end;
    until pilihan = '3';
    readln;
end.