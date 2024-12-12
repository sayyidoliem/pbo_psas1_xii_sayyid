import 'dart:io';

void main() {
  StudentManagementSayyid managementStudent = StudentManagementSayyid();
  bool isRunning = true;

  while (isRunning) {
    print('\n===MENU UTAMA PENDATAAN SISWA by Sayyid===');
    print('1. Tambah Data Siswa');
    print('2. Lihat Data Siswa');
    print('3. Cari Data Siswa');
    print('4. Edit Data Siswa');
    print('5. Hapus Data Siswa');
    print('6. Keluar');
    stdout.write('Pilih Menu 1-2-3-4-5-6: ');
    String? select = stdin.readLineSync()?.trim();

    switch (select) {
      case '1':
        managementStudent.addStudent();
        break;
      case '2':
        managementStudent.viewStudent();
        break;
      case '3':
        managementStudent.searchStudent();
        break;
      case '4':
        managementStudent.editStudent();
        break;
      case '5':
        managementStudent.removeStudent();
        break;
      case '6':
        isRunning = false;
        print('===Terima Kasih===');
        break;
      default:
        print('Pilihan tidak valid.');
    }
  }
}

class StudentSayyid {
  String name, nis, className, address;
  int age;

  StudentSayyid({
    required this.name,
    required this.age,
    required this.nis,
    required this.className,
    required this.address,
  });

  void displayInfo() {
    print('NIS: $nis, Nama: $name, Umur: $age, Kelas: $className, Alamat: $address');
  }
}

class StudentManagementSayyid {
  List<StudentSayyid> listStudent = [];

  void addStudent() {
    var details = _inputStudentDetails();
    listStudent.add(StudentSayyid(
      name: details['nama'],
      age: details['umur'],
      nis: details['nis'],
      className: details['kelas'],
      address: details['alamat'],
    ));
    print('Siswa berhasil ditambahkan.');
  }

  void viewStudent() {
    if (listStudent.isEmpty) {
      print('Belum ada data siswa.');
    } else {
      listStudent.forEach((siswa) => siswa.displayInfo());
    }
  }

  void searchStudent() {
    stdout.write('Masukkan kata kunci (NIS/Nama/Alamat/Kelas): ');
    String? query = stdin.readLineSync()?.trim();
    if (query != null) {
      var hasil = listStudent.where((siswa) =>
          siswa.nis.contains(query) ||
          siswa.name.contains(query) ||
          siswa.address.contains(query) ||
          siswa.className.contains(query)).toList();

      if (hasil.isEmpty) {
        print('Tidak ada siswa yang cocok dengan pencarian.');
      } else {
        hasil.forEach((siswa) {
          siswa.displayInfo();
          print('------------------');
        });
      }
    }
  }

  void editStudent() {
    stdout.write('Masukkan NIS Siswa yang akan diedit: ');
    String? nis = stdin.readLineSync()?.trim();
    var siswa = listStudent.firstWhere(
      (siswa) => siswa.nis == nis,
      orElse: () => throw 'Siswa dengan NIS $nis tidak ditemukan.'
    );

    print('Data siswa ditemukan. Masukkan data baru.');
    var details = _inputStudentDetails();
    siswa
      ..name = details['nama']
      ..age = details['umur']
      ..address = details['alamat']
      ..className = details['kelas'];
    print('Data berhasil diubah.');
  }

  void removeStudent() {
    print('SUBMENU HAPUS DATA SISWA');
    print('1. Berdasarkan NIS');
    print('2. Berdasarkan Kelas');
    print('3. Berdasarkan Nama');
    print('4. Berdasarkan Alamat');
    print('5. Kembali ke Menu Utama');
    stdout.write('Pilih Menu 1-5: ');
    
    int subPilihan = int.parse(stdin.readLineSync()!);

    switch (subPilihan) {
      case 1: _removeWith('nis'); break;
      case 2: _removeWith('kelas'); break;
      case 3: _removeWith('nama'); break;
      case 4: _removeWith('alamat'); break;
      case 5: print('Kembali ke Menu Utama.'); break;
      default: print('Pilihan tidak valid.');
    }
  }

  void _removeWith(String field) {
    stdout.write('Masukkan $field siswa yang ingin dihapus: ');
    String? value = stdin.readLineSync()?.trim();

    if (value != null) {
      listStudent.removeWhere((siswa) {
        bool match = false;
        switch (field) {
          case 'nis': match = siswa.nis == value; break;
          case 'kelas': match = siswa.className == value; break;
          case 'nama': match = siswa.name.contains(value); break;
          case 'alamat': match = siswa.address.contains(value); break;
        }
        return match;
      });

      print('Siswa dengan $field "$value" berhasil dihapus.');
    }
  }

  Map<String, dynamic> _inputStudentDetails() {
    stdout.write('Masukkan Nama: ');
    String? nama = stdin.readLineSync()?.trim();
    stdout.write('Masukkan Umur: ');
    int? umur = int.tryParse(stdin.readLineSync() ?? '');
    stdout.write('Masukkan NIS: ');
    String? nis = stdin.readLineSync()?.trim();
    stdout.write('Masukkan Kelas: ');
    String? kelas = stdin.readLineSync()?.trim();
    stdout.write('Masukkan Alamat: ');
    String? alamat = stdin.readLineSync()?.trim();

    if ([nama, umur, nis, kelas, alamat].any((element) => element == null)) {
      print('Data tidak valid. Harap ulangi.');
      return _inputStudentDetails();
    }

    return {'nama': nama!, 'umur': umur!, 'nis': nis!, 'kelas': kelas!, 'alamat': alamat!};
  }
}
