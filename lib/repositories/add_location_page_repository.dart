class AddLocationPageRepository {
  int _data = 0;

  Future<void> fetchData() async {
    // simulate real data fetching
    await Future.delayed(Duration(milliseconds: 600));
    // store dummy data
    _data = 99999;
  }

  int get data => _data;
}
