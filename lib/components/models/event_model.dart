class Event {
  int eventID; 
  int parentID; 
  String imageURL; 
  String name; 
  String lat; 
  String long; 
  double? rating; 
  DateTime estStartTime;
  String category;
  String description; 

  int? flightID;

  Event({
    required this.eventID,
    required this.parentID,
    required this.imageURL,
    required this.name,
    required this.lat,
    required this.long,
    this.rating,
    required this.estStartTime,
    required this.category,
    required this.description,
    this.flightID,
  });

  // factory Event.fromJson(Map<String, dynamic> json) {
  //   return Event(
  //     eventID: json['stop_id'] ?? '',
  //     parentID: json['uid'] ?? '', 
  //     imageURL: json['photo_url'] ?? '', 
  //     name: json['name'] ?? '', 
  //     lat: json['latitude'] ?? '', 
  //     long: json['longitude'] ?? '', 
  //     rating: json['rating'] != null ? double.tryParse(json['rating'].toString()) : null,
  //     estStartTime: json['estimatedStartTime'] != null ? DateTime.tryParse(json['estimatedStartTime'].toString()) ?? DateTime.now() : DateTime.now(),
  //     category: json['category'] ?? '', 
  //     description: json['description'] ?? '',
  //   );
  // }
}

List<Event> events = [
  Event(
    eventID: 1, 
    parentID: 1,
    imageURL: 'https://lh5.googleusercontent.com/p/AF1QipOLzxKxhbRCFgsUxE3GTIuVNevUfPKMa1ZBqh18=w426-h240-k-no',
    name: 'Paris Charles de Gaulle Airport',
    lat: '49.00799341496377', 
    long: '2.5508680799122603', 
    estStartTime: DateTime(2023, 09, 17, 7, 30),
    // rating: 4.3,
    category: 'flight',
    description: "Paris Charles de Gaulle Airport, commonly referred to as CDG, is one of the busiest and most iconic airports in Europe, and indeed the world.",
    flightID: 1,
  ),
  Event(
    eventID: 2,
    parentID: 1,
    imageURL: 'https://lh5.googleusercontent.com/p/AF1QipOYOd4-qWEu5rEKtQnROZWil9nQlxms3AHi35ji=w408-h544-k-no',
    name: 'Restaurant La Mosquée de Paris',
    lat: '48.84182487635057',
    long: '2.355702012420325',
    rating: 4.2,
    estStartTime: DateTime(2023, 09, 17, 13, 00),
    category: 'restaurant',
    description: 'Nestled in the heart of Paris, the enchanting Restaurant La Mosquée de Paris invites you on a culinary journey steeped in history and culture.'
  ),
  Event(
    eventID: 3, 
    parentID: 1,
    imageURL: 'https://lh5.googleusercontent.com/p/AF1QipPKel52zXPJwVdZThqMRnAlPjvhj1ZLPhVfqhJx=w408-h250-k-no',
    name: 'Louvre Museum',
    lat: '48.86074518127534',
    long: '2.337676183586351', 
    rating: 4.9,
    estStartTime: DateTime(2023, 09, 17, 15, 30),
    category: 'museum',
    description: "One of the world's most renowned and historically significant art museums. It stands as an emblem of cultural heritage and artistic achievement, drawing millions of visitors from around the globe each year."
  ),
  Event(
    eventID: 4, 
    parentID: 2,
    imageURL: 'https://lh5.googleusercontent.com/p/AF1QipPKel52zXPJwVdZThqMRnAlPjvhj1ZLPhVfqhJx=w408-h250-k-no',
    name: "St. Mark's Square, St. Mark's Basilica",
    lat: '45.434310970136266',
    long: '12.338523418541758', 
    rating: 4.7,
    estStartTime: DateTime(2023, 09, 22, 10, 30),
    category: 'attraction',
    description: "Visit St. Mark's Square, St. Mark's Basilica, and the Doge's Palace. Take a gondola ride through the canals."
  ),
    Event(
    eventID: 5, 
    parentID: 2,
    imageURL: 'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAoHCBUVFBcVFRUYGBcZGiQdGRoaGiAeGhwkIR4eHh0iHiAgICwkHh0pHh4cJTYkKS4vMzMzICI4PjgyPSwyMy8BCwsLDw4PHhISHjIpIyk0Mjc0NzIyNDIyOjQyOjI6NDIyMjIyMjIyMjIyND0yMjIyMjIyMjIyMjIyMjIyMjIyMv/AABEIALcBEwMBIgACEQEDEQH/xAAbAAACAgMBAAAAAAAAAAAAAAAEBQIDAAEGB//EAEQQAAECBAQDBQYFAQcCBgMAAAECEQADITEEEkFRImFxBROBkaEyQrHB0fAGI1Ji4RQHM3KSorLxguIVJFPC0vJDY3P/xAAaAQADAQEBAQAAAAAAAAAAAAABAgMEAAUG/8QALBEAAgICAQMDBAICAwEAAAAAAAECEQMhEjFBUQQTYSIycYEzQqHBI5GxBf/aAAwDAQACEQMRAD8AZ47LMSnMHSUvLamgJ4gM2YKLX/jJWE7tIBczCGrUgbHm99yYP7Fly1PMln8tYK5YNe7UPbQeYcEb0PWHaACEKmF3Sa6MC4ANLHN0o+sfO8XHTPVg7FqySUoQn8wvXbck6J+9ojj5yJKe7HGtX94dTsPF6J2veLgvuk0YzDWYWsBZI5c/HlCbs2SZ804iaWQ5MtGqy9+n05RSNUynF/oY4aTMEsqJZKLV4iPqHIeAMHOVLnk3Ci/7ctb7DpXpDnD40cSplUgMwoDyCdvpFGDIWQoABIIyv7Kc3suP05yNdXjotLXkDvYYpJQtmdqpYtRV/vYwo7Uw5TNSU2X8dPn5wykFeclbEFLEkjNms3JlDkGOpNKu0wDLY0KRQu+j36wSb2jJK3l09qWQRXxHzHgI2udLT7rKUQWupyaAAaPSsKMHiVlKilJZIAUzJB1qfCjVvFOO7WWlaAmWpLjKlRsFKoksNjrq8NjT6MSUtWjoFTUl862ULgEFQYO1SztoHgFc+Wk1XMWVBw4GrtYhrG2wjU1I7sJlrllUuisxUg6uFkXqHd94GCylR7yUEFgUlRBBuDlYsGIHmN4o06tC3bpjHAYoS5ZYrWogslTsn7r/ABASJayXUKvmcly9wSwZ35wUFhyGtbbqKCB8RjsntKZ6Bt/rEHJt0yqiktF82WoqCgcraABiSXJLu7mLCBWoSTfKa8xyHRoTf+JTM7IIO5LEeoNeQrB8lcxdO8V4KyD0EPe9gSS6E0YAZcudWXarRaiXkAALgWBDt0JrqYpnCYGIJIYkEzlvQsaG9aRZMnrlpKixAYqZRo5ZOtSY58hlFEEyuMqzF1XJIIPgQRp6RRMwSiKL8Sn6EaxbiO0gzEs6QpOZ3L+J5RQpSglS3bLppfeEbb6h4JBkicoJKZozAl8wDsdaFqGtBCjEyxnSAMqCphdhW9Xbxg8YxyAkmuhFW3hZicav2UAqUpQCUtfWgaoozw0W2CcVWxph8QkMnIfaIuXuWFTQ+H8WKx4QoiYGFGzDRW4NQaMbwPhMNMlzCgJ7xTFSl6BZDJQk/pSHfmT0inGdlT1pCJ6kpUkBSZyT7VWKFJ1PTlDuPkW32GRWUoWVF1LOUNdv/q8AYPClc8uAyLeLevhrFM6UpCEqzhwcqQbsAfRnqfOsG9lz8jp9lai/FetutIz97KJ7poaTFVDngeh0o19+LXYQlxMlZmOWZ33UNhepaGOIQV5S6uDYaHQ/PyZ7U45aWdLgCja0Zj1Up+lNoLddB4J2ZicGFS0gqyzDdJ1rbpUU5RLAYlMwmUtVRcm6VOw8C9y77l4jLmCewUxUQykuHswO+w2L7xASA4WwMxAYlqzEh2UP3bjX4C+qGoMGZCyg0Dh6eo6/dgSVPwneILHiTYpNTuKV39YEXjSpKAEFS7JL1U9gzeJOmV4fyZKgngyulJIOmjjoFVemnOEdsSWjm8Bhv6uYlAZEqWCqaoUAA91zalL7mFn4p7bGIXkRwYeUGQBSlnb9StBoG5ww/EOOTIlDBSSConNiJgpmXdSeSQanoBvHIlme4Bpuo7tHqemwqCtmWUuTskDM0OUaAG0biqYQCcxL6swjIvzXg7gzpPw32x3EwGqpKyykkVDfBaQS24jvsQczKDKlqSc5ukg70qkpYJ09rUR5WpAGZWXlNQL8lJ53L+EdP+GO1QP/AC8xTy1j8tbtc25AnyV1MZM2PkuSJwlT2XS8EmZLMsk5EksojiMsWD3JAOWl6aiKZ60BJWod3LlhqCyRZI/cbNDmZKIzSiACbncVNuZcci4hT2pJQtKEs6EGoLVUzOoa8njGpJvZvQu7MkTMSszFAy5QqgWSBo/6jcv1hklCQMssMh6li6nOtyEuaJ8+RM7EKUhKAlgBxAb7eDeJHKo2NxKZYbU2HO3hDOW9CN0rZvET0ywQavYanX46wJKmjMhc9JyKBZArcMCx0q9Yt7SwZkqCi0xZIDXDkOCBqLjw5xvD4XKAuZxLvUvV39LPYaPHEm7dAeHwJTNUoE90RueMFiHHKvUjxh1iAhB4kJWnR0hxszMTQjXwMLj2invEAmirN91HOGU8vLcXQ4PTT0eOg6lsZrRDDSZSSVIls7+wqijqz+9yLGBp+PlqIZACcpSnvAyyu4ATsAC56Ql7KmsJizwmYo0JaxLN+4A3jeJUtSs2TiTxObqy11rv6w3uVJoRr6b7h60ABBJYMz9LebiE2LUmY4AJNwpVAL25Xh7NZUqmh/4bbSKUyE5So1JYg6jptV4V/dYzmorZTgJSZcske9Tq4UH82gjASVhRYcBc0NU9evzgbvcqjnICSDoakNbY1EXTmUhwCAoXFD4jaCna2BzphWLQVEPwgOzA7g33cD13ipRzPmWHJc02szfOE6pcxChlGarNd/CHUjDluIcV6Bm6D6vBlCXWxuaBsRhQooUfdYijp4WagNqARXPnZnBl5acTEsqrvszUaClTWHtE+X0EDLU5cgsQw0v1gVKtirJso7NQ847JAA8n+kMcHje7mB5YUMpAIoU3ysW1ykeUQ7PBAWpQYgGh8vrC3LMzqWFJCfZZVmFL75nPlB5Vsd3KqR0Rx3doK1mXKTZkl8r6A3Us+AHxrwuJ70gKQyUHNLNy2rnxBysGbWEOPS8shbOA6WFnDOC8O/wzLUJAUu5FOlh8PWAppxt9TmqlRLtPCpWUsAkpqB10O4LQpnrKlgTQAdFAUProNWpSGPac5lcIcJ9pvnrS1I3LyzEMa7H+fn8Yn8jNeAOXiSk5Jl2BSt6Gu9iOejh9YYs5dgK23t6v8tawJhFIw5WJqSqWXag2LJ/bWri+gpEMBNUnhU2UEAEVAOzm7O2rPtAkgQm1osx3Z5mFMyUcpQH4RxDcvdQI0Ox6QZhZxWhJIaYmignU1IUNwa+cWSiUqC0kauLOPtn8DoYzBIGdWUGhrRwLnKRvYkaOI6TtbLJ9yxMkoUJgDAVGvXTW3lE+1u0xhZZUlR7yZmEsE1ALJVMO4ZISjcgq1LETpqEJXNmUlosBTMqwSnqxHIBSv0mPP+0seufMVMWeJVUj3UJFA2wAoB4xq9Lh5PlLoZs0/wCqA1qclyd1n/2/XnFslLnMvh4SUn9At5n73iEqW4dLMlikGmaodR5RbPImIVxESwTla6lX8hG2UuyEiu5sqmq4ky6GzpH0jUSlOQCZqhyAoIyJ6GClAr/MRTKC73zFVUn9pem0DZgKiiCajWWr6b+cElIlgFAUFgsUkE53ND0eMUgZQtNX4VA3USVEg8wLH7HRkZ2jrex8f/VS+6mFp8scCn9sNqdaM52ZV0l753YxSApCiFiq0mrpLO/700UNP80cThpipakKQohi8pWoI9w+NvKPSOwccjFSyWAmAATAPaDOzD9L22toIz5sVfUimPJWmJcStMmXnU4IB5agCh6UML8VJBlIxSE5yUMpBqKnwtbcEuI6PGKyzONCVpmBglVlVAISdFXAF4VyeyzLmzcjlBSkykFXCHAKidHFA4fkaRmXlPoXbt7A8GgoQDMJVMb3vdGw2G8JO1O0FTDklnhdjT2t/wDp5awR2vNmCYJauEXVuejUaCkLSlARLSyNeJ1FtXsN6btBT/sFR7IAwMrjUV1IDdDow3YGmkdThC4D+8Mp66P97wlwEsSg9K66Dx1feGWEWxbRVU+ECW9hVU0IFYYS8XlYtlKkbOSLcwkq9YZSsPLFS5f2lUKmo16XLRb+IZKiETJYckgK3Yn6v5iFkjNMqDMASrLzJNzV+Wl4aS100InT+QvAKdCgC/tAb8JID82AjMOOFvDn8ovRgky05800FRdIUQXsnRIYEARuWhIcnWsCcWL1QHiJDkB/QMP4gvBYdKAcy3ejOSGpaInFS6s1OVbbG8aTi0uagJFAWqS7EGrAPR3vHJo6MK67CEISgulVehfnpGTVKUpyq1mBifczDVJSUuxJFQ3S+sUTMSBwhQKmJsGoW0sHp1ivRbOST6EpUuWL1POIYtlUDDYiKVY/hBUQ+297b284slDOnMJawN2YfKD7iaoHtlaS0svqoeQqYjhFp7sJIAJFXLlRIJ6XYNFSJAmKEsqUCTlCWooFyrVwWBDxfPw0xJWoIYy0lUsJAFU6K3Dh35iJyTopdMWY1IUuWhLOlRGUGodgLdCfsx1a1CVLAAZKEufJk/fKOd7Bwa5k/vZiQkZXA52J8nhr26hUyWpCVAFVT8hy38YWX0qmNH6noVIzF1yyCVEFSTZR66Gt43h1slJrnNthqxa8Vdl4VSEKUT7FwoVB1OxTFs7MQtaWUmhoXZizjdmIOtuoFPyUkktjCXMTMSUrbZQ0blyfXTzcOZIWhsMkt3j5F0FnUc1KNq2w0MC/hmSvEYvOklMtA4uZN/X4COm7QRLzCWkupNnNSWZn5g5fEbQXFx0yUqfQo7MlrCQhakqUzJWHZQ3IuDuNbw6RJGXKwCWJUczMXdRJ0YO6thyAIOGlFCFLUDxKCZCPeUAoO25qTp5Qs/GXbIBVhpTBg01Yrb3Q2js+5AGkHFieSfwJPJS0JvxL2v36wiX/AHMvhlptnNiSOdOiQBCZCMyii+qyPeI90crRuWhTsKKIp+0H/wBxixQJTklsCEuon3XAdL/qJj09RXFE0itU1Gbuyo5Q5cCqqjhTvoI0hBBUoAJBNBoAoB2fVn8oOQpASSwaWzAF2JpQt5mKO9LZcmpcX5Ac9IRPegsql4ogAMKfe0aglMn9Rlg6jKKRkdyXkH1EsNLKUhQUQxzMLDw5wSyipcwZRQEgUzBqq2dmMBT1rljuyCSRwEWPMH5QXiVD+6SmiEgAl2Lh1mgvUeBPKLTjF04+DPFtXyK5qQQVDiQo1Gtkh/8AG+msXdldozJMwTEl1DymJ1fctfwNxFaFEkqShISlIK0Pcg3SLUYGK50sNmB4SXBF0/uHi7jxiK8Mdruj0HBqlzQg5uFak9ypqoyuVS1Ee8DZ7ggwqx06alRmlJQmWvIUt7AHsdQQDXpvCTsPtTu1KlzA8tbCYkafpmI2Y/MaiOuE2ipa2WVJDE1TNlsplA0Yhxq4IGzDLkx+3K+xSM7Qi7dlJxSFKCcs6VXL+pOo9R5jeE/ZMxU0HMspZgqg0DBhazeMOZmLTMabLouWwU4Azpa5AuUklJ1KWN0wqx+GloX3iQ0qb/oV7wLfd4m0qLwkw8KSXCTQ0qalr/KA0TwhmWSoK4U7Dc84s78kFEshKE3UfaJFXIFW2H8mIdl9lEHvZpvYWJ5nYRNJNtlKUXZ0spedBbbMPG484E7HUVoS9M61KI6EpbySr0ilGOyKSRZ2Iawbn9YKwqggZqFZ4w3spd6ilzXzEPGWqItbsExilrWN00CQ9Lf6WCR4RdhZkxASnvE1sBUncM9RQ/bQNiFcIUzJeqUuxrc/q8tDFM1JAlsySRUEszF731vyMdKW7OjHWwpWGzTEuAQlyQbUUANn9rlSMGDSQ6ZQfMaLrQm+oYHcP1i9SAVA1oLgtcNfzjdherbk+bGOUo+DuL8hGEVLlImgrsp6glioMADq5c78UL04bIySM6bgnMolR9rhFdyxfxrGMXFE3L0J0ozxtBoc13o2YAX/AIhuZyxpFWJw1JZDJZQFAXtmoo3tUXFIIVLLJeYwbKH11NyQ9b/SInKbDnQjwvV2iM8BUxNSzDMQ9A5NT06GEchlDyQkyChSVJIob6As1W0evjtBsknIgMpRYpLVJAAAJNrEeULpOcTC6QBUgizVZ9DBMo+yoGqiHCXAOgcbsT0aDGXZhcK2b7IQpEnjIzksSKsH31o1YqxSwSpRcHfYDSKp2KOZCcxZJUXGwLAMNLReFpmBrHfeJylydjR1oDKHTMyH2ku5caXHmRrCgYhSJZQn/wDI6Up63PIu3i0PJoAGUqyqFdqMXOzQv/DslKirFL/u5dJYOpMGD7sZ6VMb4PD/ANPLlyJZaYrjmqdsoFTXT/iL5HZ6QlMyeogqV3i2IolAzJTvnIOZtmhTMxq2zJP5syYLkCyuEHMGCcwBPQbQ7UnukKM4NJlZXDsZyyhDILUKQwUqG4yel3IylRrtftTuk94P72Y/9OhgDLQqhmEaKU1PExwykl6VJqP3H9R5Cw/mL+08audMWtZdajxctkDajPsKbxTVIdnXctUAA35BLU3j0YxWONLqRS5OzVhwuVEDMpnYKKeI/ufyjJyUpOVIuHLnagPU1eJCWahKlEGpc1VSpGxO0YsKVkADkOKUpQjyhrpjPaNYRbKKGcKDEdPv7aLlFKXCWzanRP1MRCQlwk8RopW3IRWoEEpS2x5eOrxKUk39I6i0tku7Rqa6uDGRDuRr8P4jIH7CNEKahcpvzHMGNlCnKwQoEVJpS5IbWiXHLnSlUsiqTw3p9+kWJAcKSVCtG+fhDxnxMzjYvxZL5U+yaguCFPR6aM9IKkLCsyglKUgDMgFi9QVJBs1IsxuH71iKTAPZ0Iq2Xny+cLsMg5wGIUDSni3OBklU010HhFcWn1Lp0pmYhj7B0H7T+0uA2hjpfwh2skLlyp1Ehf5alVMtRDKSf2qB6WVvCTEyWJ95KySQlJZIb2h8xSB1BrVexf2hs+490+HUtKSp9CbXdHV9tSUyMWrMngmByElgS9WOUBJNCwBZxvFCcGhae7fNKmhkm5QsaHmC3UFJ3i/AT04+R/TTFNNRxSltVQTdJD+01G5cq24HATZMopUQpSVJURQsBTMCPaZw+wUbgRnyR4uh4TFHZWFWMwmJrKVkG6iwI8GIMMVAqLJqpqnRI5c4J7RdahlIBJt7wDe18KnaIUAKUh8oKiN715k1IGrPGZLZd29FE3CAyzkvcHnziGBXmQxY5fgremhhjLWClJZixpW2nj1hVkaYvIRkNCSC1bjqDHOk7QPgIXLCXZRAo1nN3q9L2A+MRw6QkLIpmFakv1rU0UPGJykSzLWokcSTxKuCLANarfy0QwdEgKGreBII9aeMcg7RijnS/sk8JINtHB8XgXFTJiGCQoJF1XKvGD1oCQQke85yvem/8xQhLUCQE61r/wAtAlFtFISSdgSFqrmKiXpcjW8VoxE3MMju+1CHYu/LxhqVorQUu5NOsRml2ypDNzZvt4VY6d2V9z4NSE1FANSBYGjttFiF5gom7Mz0/SPimIYdQChRh1pze8WBhlAbenJ29W8oLsmDmagFSHarA6GtaV5iLZkwJClBgEJffiVwjXZz4xXgwkJKFNmUeIKDlgKMer+cCzEkpKU/5TfZxqaaQtg2wjsXChQVMVYnKk8tT1uYzE4YpGdApqNRzHOD8EtGRCUhwGDfF/FomjOQSpmBYEeZNNHv5waTQGrFvaHZ5nSxLcZ1BJBSdCoP8DSCO0MMJCAgJeVJQDlccazZ+QZz5axhl5F5gC9coBACVXU52YFvswRPw8uYiYtYMwzFhASL2BSlIf2ySC9gBpcGL7MDboW/g6QMTN75fDLkpHE9BQkVBB4Ug13a8Bfintzv5hKeGWh8gPXiWrck+rbVZ/ijtJEpH9JhqISfzCG4lfocVIBuST6COOSq6jo1teg6W849THjUVb6ma3J2TlotRyWyjU6l/KvIxVNmsGBVxAZ+etOQtBSEVDgFRqC5ZKWr0Ar1iiXhXUcyuEbXOzeXpE8nLsXhSZLCynS7sBc/TcmCc4ZkjKPeOp+94y9PZCRQaDXz5xUAVByWQPX720hW29HJJEASbMANbfY5xRicUlAyoqdeXXbpcxVjMeGZJyp3Gv8Ah/8Al5QmXNzUAYdW6+MXxYXL8EsmVR/JevFVPEo9Cw8A9IyKEkjT1EbjT7cPH+TP7szosLilS6KdSadR03HrDNGWYQtBHTeAVIcaRrs6S8wkFQpUDyD+d+UZXGhceXlp9RolIqSWrTqPhe8VTmcqUWLAZrF2r419It7viFWB+FP58oX9pYrLlSzqW5arHZwL1UQ3KHglyVlJ9AyRNKhlPtGxFM+5G0wajWKMSjK9Py1Gwc5aBzyD3GlIFkpKQe8LJuU+9RyCG9ki+8MJOJCuBRcqF7Zwd/0zG8D5iKZcfeJOGSnxYNKKkKCkkgg5gRellD9zCu4D3FO27Kx6Z8tYJCcwaYEsMilN+Yk/+msXG5/cI45coIr7pNDbIXLC7sPS9otwuJVJmBaWpcH2SDQgj9ChcaO9jGeUFONMrdO0dovBsqoZSqHo9QD1LDkIoWhQUrRL0IF6B1V50H0EEzMQmfKRMlu44S54kqsQo3PXx3gbFzSUpSLkt03pyHqY8/7W0aou1YHOWFOPZQKEi/ROr1itTME5AC7pHvAcz7o3b1iWHWSOEanK/IXPRyD5axrIWKhxJZ1Ko6tK8ukKnY9UbSAC6qka+6P8I+dT1jaGNbga6lr8nrA01bqyscwNvdZqc6wZLwq0pSVChLMPk9fGKqNIRskgAUUsFl0oXaooAzHX4RWhSWytlDu5YVLjyteITCxLgs7das7jelYonrX3mRCUmqg5BPskAHyMK+oyBJ2GWZk1QQClYYceUijF3B5WhnJWEBNnCSCD0KfV40mVMLhS0O7UA50qL0gTFLmJIByqBID5dyNjAtj1YwQuWwukAHhy0Jq1RQG1TtFCgB7wVQAm1avXZgD4xQtNE5QylB6O1D6UaLkSySlIuoV0rbzAEDqcaXxBiHI3v4GIpVkOYsRYk7bK+vyirEylI9pxr/yOkW4YKWCaApAKjpuQd2vCSVbRyCVSSBnQNajfrq7N6bwZg15mar82+9j16wvQrKWB4VUHK9OYNWP1grAoKVD93ofkSIClWwNBsyQlasgGjkEUBDGvoPSAO1u0hIlpUhRMxSfynABQFUXNIFQpdkg2HWDlTUyELmLAYUyfqX+lJ1G52fWOAx2LXNmKmLU6lF1HTk2wAoBoPARs9Nit8pdCGR3pAyy5rYX+nU/xFkkFwwdR9gA6EVfbmeUbkyiWp/hG9iC701d7Q8wmDEsFSmUpQeuu1LhHx10j1MWGWWXwZc+dYo+W+iBcPIShs/ETU89n2SKMNb7CA8T/AHi6X4vvzVDeTNlqLkKzHqUlrs9tbmFnai0mYkpdrMQQRVhfkonwjX6vFFYKiujM3pMkvdfLq0CqWCCo6DQXbl0hVje0Ho1NBp479LdYcIAygWu/j/Ec1iJeVRGxaPOwQjKX1HoZZOK0Vo4lVjRQASLkFvKNxGWoP4325842teOhkvybKWjcETZ6ASA7C1RGRHk/A/H5OhXJaqD4GC8DQKVz8mDfE+kB5ykPo0MEoyoYDTXXU+LmJyhVGf0+22aRY9GG9aD0J8vGFfais8zgXlUgAXt7zH9Jqz26Q3TKHABc1PP3R6GFeP7MzrMyWciyXcWPUQILjLZonK1oVlC1KCVKUC7MTbV4YpGShOajFzTwA18WiCMQD+XNTlXoRbw26W6RahJQ5SU6VY7Avl3bnFrS2Ru9DHCTswZbh6OS19FH9TFgrWx5xmICVFD0FRfgv1ZIDCup2MBScOhWaYtalKIVdTAsPdA8Kc4ux8spmPVqB72AFtaD4xlzSitx7mnFBvTGPY/aKpEyoJQpgpO+zcxoeqevWYqahagqWpwZYKTYKSaFidXpyID3jhVhjkVoKcv+zS9K6MzPsfHhB7uYWQS6VGuRVieaSKKGordNM+bHyVrqUi3F7Ha5YVm4sqlexVhQukHQZq3N2irs6ZXKoe0WVS9Ln4NyO0GrQUkFA43ZQoWGvmCGVqC+sD9oJqmYmgWWWOZ1PI36g7xkgr0y789mVSyETFpXZId9xoX9PPlGLxipiSUAhLHi1P8AhH/HyirtAZ5YW2ZSOFYIuHFW5RYcQwKU1Ov6Ryu3XSKJ30BRRMWVIQGcMGOtx4XTF39OoqJsbm1GAB5i3wiaVlquDvrSvhFa5rAEB3qPG4rSEbXkdAmMxHdqUMqlZQFE5j7xItXaL14XYE211Lszm9I0rEqdso51bx+PlGCYokOGP3rCqUWNxaRBToUnhFGAJL2YUI1oImMOvMtSSVB2KSKEtpt99In3tSNEqbk4L0HXX6xn9SUVIdOv8fSCmvJ2wfF44KlqITxpplNCDRm3Bp9sATNV3UpKT7SqrPM6c9t4rSgTJoW3AhIWT+o1y+AvFvdd7MCVHgHEvQgaDrt1fSFfUN6I4TCnuytb8YYG+VLio5lTJSWsH1MHSlMxVlBSXmK91AQ2YuKnSmpKQwaLVoK1BbEIBypAuP05RSpoI5j8Qdq5j3MsukEZ1D31B2AOqE1bclStQI7HBzlXYSbr8lHb/a6sTMtlQHCE/pGpPM6noLAwuQBmSkan6sfNm5GIpo1HDh9j/wBo9W2vaJLTCqwSaDXk/OjtG9yqkugigGYadLQHLuaPkUR6CieWtztBsvtEISolYmJd6kEHw09IWTgVJSlOUrLJSnKCokHLQmgqNYkewMRMTWUxY3WL6e8zW0j3cORRjSWjxM2Nt8pSVsLVPM5Ty0hAbis3VyKfd7QJ21gcglkOywWUQ2Y2cPUitzDvAfh+ckBzLSQAwUp0ZrOQzHSDPxZ2BMl4UTZkzPMCwFbAKBFPFtoPqZKcOP8AgX0z45U1v5OMCjmdjUP4EP4a+UA4rChS1F2sbb/y8He6k9R60+MUT6KSa1cfMfEx5UU4M9if1RF47LL+0Gq7aQvxMrIoob5OIezlsHtFAnOGUzc4ssjvZmaQnIahFReMhsVpNwnyP1jIb3ECkMpSiuYA1z4NvDTEKqEgVv8AP4sPGB8AklbtTLoGckj5PBiqklywq33cFhX6wXDbbI4dRIIPEpQskZU+AZ/NQiRtyiEv2RzP8/NMSUpq7V8ozzTtFmxCUZ55LW+Q+sTnzJhUWDIctw1IBYHys0Z2WoupZ6/FXyg1AzLQwOVKU1PRh8XhJ9RoIHw09WdMsp4SQC7gkhiXDfphrOPsvu4Y1BAq3g/WF/ZwUfaBCsxNTVmUkU0qfQQTNmJzDMcqi+QtpS+7vEpR3ReL6s3OQONe5DFhqdKVEVzENw+X/P20EgVAVu9LHVwflBWPloZJS3FSjNRvWFC3YZ2H2iVASlHjAZGmdP8A6Z5/pOh4bEGHJwoIKy+SY7u1nLB7jQ9WjhVFiN7g/D78I63sbtZM6WRMqtNV829/n+4f9X6ojkx39UQxk1p9CuU8uYZcyo3/AFJNj9/KNIlgOXADs9irQejQVjQ5SLlJIBG2ofUWPI9YqxaHBSQxLeDWb70iDd9CyKVgBRNmoSSwZ3udXiMsjK7u1HAOVjzGvnGzIUFGudJTmBUaX4qWLM4ppFSFBCim5Z8wYUBbzA6w1JdQW30LhMyJOZGZ6Pl9nz+cVShmAIBZ3JIrb/FvtFqpjAulP+au9qvaBp0wVJA6A7kNWOfDuFKXYitQPCSC5LixJvT0i0saFuIEtvu21aRQvDKKFNxEijEir8Nj9DBRlJQsgkqoEknSrlvH4DnEpRroUTJ96Ey+H2ibNq7JHkPSDMNgAhPdrUxICph60azMLdSTA6UlMxKiLBx10LakB/Q6RPtXtUSZeahNQkEe0rWh9xNzuSBbNHRTm+K6iydIB/EHandp7pFFkNT3EkN/nWPJJahUW5ZCHtUl/han3pG+8K1ZlKJUo1JqXJc9TW/ODsAQKke6CKVoSLbxspQjxQkVe2CrlioJssFuTDzpYdOcWrXmUp7s/m4PjSNTqkqfKHNfp9YHlYhKyUoplYuXD1rBjFvaC5FM2YZakTHLS5oV5kLPhHqmIwvENi7eFB6CPK8dLCsyNCkkcjUD0Bj1bsyf3uHkTNVS0K80JB9QqPb9Izwv/ox0n4F3beBeSopABFRTUVjpO20DEYCYR78rOnwAWPhA86WFyyNwRBn4Z4sKlCh7OZBB2BIH+lotndpPwzL6J1Jo8Uye0NGB8qf7TGTkgIe7EGnkfQwTjZHdzVyz7qyj4p+UVIQFJUnejbPQfERhyQpnuwlaAZymQATcuHFG2MDoSOXgPrBBOYD1ivKADSsLVEZdTXeJ2jIrz/bRuF4gs6nBpZJUK5i48mHzjC7HmWrf7oPONpTklgVoAKX+3iKiOEb1+Q9QPONzhozRdE2qBoB8T9AIox6sstZ5N50gpFz1+FIWdsrOUDQq+H2IhPG7seMr0D4ZLSlGz09R8gqIKkrCgkKCjViGZk3s0GSpfAAbMVHwAHxWfKAEP3gLUYpZtD0PM1iLxloS7jSQk51FTOwFNr7naF/axeYlL6AP1Nz4QywsnICNib3sPmTCnGgqnn/EBBhjubb7BlOol2Gxi5ZyzKpP3SHGHWlVUF07ag/OFXaiPZ6n4A/WBcLMKVjKpqtyA5wJen5x5R0zll4un0Hk2SkKzEghsrG1h50itCzLUmZLVV3SoX/5+OsbmLzpQpQYkvQXLHTUtEpUlJAq4vsC4NhpcRBwSh8leTcvg6rsuemekrSACkcSR7p5D9JAcHRiNiVuIQqZMIc5W0cdQT90hbg58zDnvBrStlJNwev3UR0mGTLmS+8lHgmKJqeJJJdQPMFhTQJOsYsmPi3JFsc70wFSkocEnK3CLAMK12bTeK08TFiCzMr50+UFKWOJkhg4INrVHrFYsKUowH391iK+Sv4JK5Zba5fSAsQ5oU0LVH3rtFqzWoH+aMKdh0LuBCt2OlRBMyqk8SVBgHuH2pbnWwtFvdn3Q+gHoHPr4GNixZIuHb2iwYenxMMMChLZyQEM6lEsA1X+fhCvroN62aExKJJmrUyR7zVU+iQXcnR+psY4rF4heImuaaJSLJSLAfzuSb1J7Z7R75YTLBEtFEJOu61cyfu8CS+A5iCSkG2tvWkbsGNQkk+5nnJuLYbjuz+6TLVc1NNDTzgOZOSgOo10AvDftbs6fLlhcyiSpk8Wapc7bDeOcyAgg3NzreNfqMUfc1paI4cr9tXt7B8TilTOSdo32YGmdUn0/wCIpUggkG/2InhCUzUgggu3nSNEYRUKRPm3NNh+OlA3GnwYj/cY9A/A80rwEupCkFaDvwzFEXtwrEcLNNRzPxCvoI6z+zDEhUvES9poVV7LltrzlxT07pWZvXRuDOylSyR7Sv8AMR8I1+HZqs8+WpRUUqChmJJAUGaunD6xbh9uXwgbBnJjOUyWR4pII9HjRNWmjysEqmmef/jvDZMZNYe0yx4gE+oVCVHtFtbeNfpHa/2pYTjlTP1JKT/0kH4KMcLJV7L7MfA0+AiLjaTPdxy1QJOUQpQDAO/nX5wOqaNASddoMx6ePqG8QfoRAS0F7RPjYs9SNd8dhG40oq2T5RkTOOsmk0Fa3OhN6+ka94nb5CvwEVpU6uQJppSvyEbkAt1+v0THpcbZhulZekMITdpLzTEp2HxMO1mkIFcU0nb5BvjCzhqjscthGIRMUwltUVqAzkkX5FPkIvxWESlP5SQqtxszEEk1Lh4qWg8ShZLjqzIBpoEpPmIpwyCZZU5yhTgDkCPByHhPb3Xksp6sZYawOpv/ANRJ+YhLhgVTn3UT6w6fIk/tB/0inwhF2SBnL1owHOHhi1JizydEPMjoINyCLUfQ+EIVBiQdC0P0qOoYJ/iAO0pI9sCr18onjXF8fIZSvYVOXllyk/qAHoHaK/65MuWCxKc5SN2A+ukF4pFmagavNrc6QF20ngQCACSbWoAIyrBylT6Gj3KVjFU4TJWYcTEU8WYjx+cZ2Tj1yJtU/lq9pNObEH9YBLHVyNTC7D5UCYHIGZCQ13JJ+UEDFvnQA6k2B1qE+F4hmwuLorjmpKzrZ6EsCg50MC7e2C7ltCNtwRcQrxCyOF+EUvU9d9fKBez+0RI4ZhPdKPtXKCw4m1FnGrbgQficKcwSmoIGUgvmBFC9XffaPKyxcXS7m3G0+oMmcWubb/yHiCFkqoQLfz8TDNHZiUpZawDs/wDMDTcIZZd3BN778tOsTlinBcmNGUW6QRgpalFhrVR9AkcqP/yIU/iLtQKJkSi8sF1n9Z5fsHqa7Rb2pjTLHcSz+YoPMOiARYHcivLqaI1oUmUF5QU51ICveJypJB5MQ3jGn02Fy+p/oTLNJomtCEy0Ee3XMX6bdNoDRiCtSm6gnVjWkdHigP8Aw2Qr/wDav4qMcthSyiNnj0/aSkn+DIslpr5Z6F+JuLCpXv3avMf90cIm562jvO1EZuzJZ1EqVXoUA/OPPgeI/esW9TG5J/Bk9JqDXhslPHvX2DaxCckE59Ul/gfrF848J84FPsKO30/mJY7s0MYzzbkR6KHyJh1/ZzOSjFz5QBGaWFlzfIsO3gswhWp08ymnUpf4wf8AhWYlGPk1AMzMgjVly1Ef6gI0YloT1CuLXweoyphCmy66q/7Ypxk0ImSVqSHCwkHOaZuE0atDBJPE+4Bgbt6VmkqIuOIdRWNWm0vJ4Kk4u/AN/aRhc+EzC6Fg+CgUn1IjymUHBH7n6OH+Ue29syxPwcxvflZk9WzJ9Wjw9NFEbg+hzf7YjDca8HuY3slj0nK+oPixp9IWkEw1mIzIUL0PndudRCxCBQiIy0Un5K35GMizOdxGQnFgtHSIUQlRvRvXboD5wRKTQfHpwj5xRYDqVHw/+p84KlhvBh6OfWPWjHZ5k5VEhiVMIRdlLzKUs7ufMqPomGna8xpajybzp84Xdlo/L/xFvAlKPgVQso3JI7HKotk/6uZkYpR3YoSSHLgaE1J2G8XS8QtxKKEhBYuDdyHZqNUwL2jgiVIUgniLMaZXHhWsG4WRkygkk6vYBlU5nM1fssoOx21x0Tx6mlr5hvEn6GAOyMMAy3rZttD1/mC+2VlMsb5gPIGJSEgJSAGYNbxPrDVUfyTlK2EqOnr4iAsSaywxqsfEAvF09bGpoxEQlB1gX4hrsHeEWPd9hlLsXY6aygWehPKjfWKu0APykG7MPMP8IJmYbORxFLGrG4It6QNjQDMQdh8b+jx0cVbHeRf+kESc4V//AEB8gqnWsSw8sd5MPM/70tBGGllLuWdZI/y6RHDsCS4qfmT8oGT06lJnQytRQJiw0pGxUX8ACOmsOvwj2g0taZh4ENkUQ5l5tP8AA9eXiYT9pTB3KQKkEv8AAfGLPw/PQJM8KUyhkLG4ZbH4iPJzejXu12o9DHn/AOO/kb9rTzLWzpcm7u/PxjWJ7RVKKZaMpWoJKXqApaQ3kT0oISdnSZcxSwqamWEoWoE1zKDEJABDOCS+kUdo44CZLyqBUmVKNGUAoS0FqUcHSMs/Qyirl5X/AEaY+ojJ0vAT2SgnFhEyqu8KVkl8xcgudaxMo/8AIJG2JV6y0fSAuwsaFYpExagB3oUs2AdVX2Dwb3g/oilxmGIBZ6sZZDttSNeCCjF18mfLNuSv4Gqi/ZUv9uII85ZV845NJ/MI3B+EdRJL9lK/biQfOWBHL++Ovyi8kk0ycH935PRkjP2U72lrH+Rav/jHnyrx6B2K6+zVJ/bNHnmI9CI89av397w3qI6X7I+le5L5LkHMkphfiHqAaD1g5AL0rAeJAC+URxVys0y6UMMMrgQeQ+JEViYqXOw04AflrQVHUBK0u/JgfMxHALeW22b6iMxqR3ZOxPrVulY0Y4p2ieTse2LBcMHZx6lvRosxEsqQQ1w0KcPMTOkyppD55aFW/UhJ+OaDZUhJRYeUVrSZ4UtSaDuwUqGHSlYYpBSQdgSB/paPFO1pHdT1oPuTSnwcpPoBHrn4V4DPl/pmZh0UPqkx55/aLhcmLmHRaQoeID/6kmFiqm4/s9X087hFiGUb3cG2zfZhatDEp2JDnrT0g8KdV/aD+Y9bwDjSyuSgD1anyiORbNj6GZR+oRuA+8TuIyI8TtD6R2qFkcDAML1uPofOHOFJIzPcmh0rGRkevi6HkZ9MV9vr4QNyPRz9IySciEHofQn4rHlGRkd/Zhj9iKlZlZZhNEueTlrh3owt6QVhJ2ZINeFOWuuYj5CNxkOHsKpeNViaqASm4AvWG60hMZGRODtKwZtN0AYiUspz0Y2EXd4USytPtBJKepDD1IjUZGrP9q/Yvp+r/RXJmq72WFHMWzKoNC48r+MWksslX6so5AAt1eMjIlDsUyf6MM18q9pRFdKfGB0YhISsZeGUgEubuKi1qqEZGQe8v2cvtj+iHY81U1AzJQUOKBx7PEQOoyxHtDDq/OMtQSpKVEhqLQEh35poa3IjIyBKCljVjxk1kdeAZE6WMPNdIKkJCicoBAKkgZSGYuz9BFGHmImFZlS1sCnK6kg3IJJ0Q/ugPasZGRFdkXfcZqQFYidxBAStSxwu3GBlLVLmrjlA6ESzP7slQWtRlo/STnKEvWgUWHK8bjIEscXeu50W6X4MxE6ZKQlIUTLCnUgKISoBQBJH6gLGNy5XeKWhB4kGpPLTxjIyM7irX5HloY9p45ScHKCVrS81VElgfy5Rq1aE/GEuFnk5S+h+YjIyE9R9wcHT9h41gTFDW7GMjIhHqUkRM0oytYmvjSCMUnNLJ5pP/tp5RkZGrGtsSb0j078GT82AlN7oUj/JMUB6EQ/wirjlGRkU/qzxM38jB+zFZcaoaLl+qSG9CY5/+1PDgKkzGukpP/SQR/uMZGQkv5V+P9G/0f8AH+zzaZiWADVGu+3S8ZjmKUq5/wC4fxGRkRl1Z6L6CPwEZGRkCwH/2Q==',
    name: "Gallerie dell'Accademia, Peggy Guggenheim Collection",
    lat: '45.431001570970466',
    long: '12.331548125702948', 
    rating: 4.6,
    estStartTime: DateTime(2023, 09, 22, 14, 00),
    category: 'museum',
    description: "Explore the rich art and culture of Venice. Visit the Gallerie dell'Accademia, Peggy Guggenheim Collection, and enjoy a leisurely lunch at a local trattoria.."
  ),
    Event(
    eventID: 6, 
    parentID: 2,
    imageURL: 'https://lh5.googleusercontent.com/p/AF1QipMJ72QJY9yT8cxcGi9DURYuT9k0vaF8B2xI2Dgi=w408-h306-k-no',
    name: 'Islands of Murano, Burano, and Torcello',
    lat: '45.497870211050355',
    long: '12.415000913245477', 
    rating: 4.4,
    estStartTime: DateTime(2023, 09, 22, 18, 15),
    category: 'beach',
    description: "Take a day trip to the nearby islands of Murano, Burano, and Torcello. Explore Murano's glass factories, Burano's colorful houses, and Torcello's historic sites."
  ),
    Event(
    eventID: 7, 
    parentID: 2,
    imageURL: 'https://lh5.googleusercontent.com/p/AF1QipMD27bF8x4xJVNRdcbIx6hL5D59KTEsAKMLEtfQ=w535-h240-k-no',
    name: 'Venice Fashion',
    lat: '45.443606930533214',
    long: '12.325605885211214', 
    rating: 4.7,
    estStartTime: DateTime(2023, 09, 22, 21, 30),
    category: 'shopping',
    description: "Spend your evening leisurely exploring any remaining areas of interest or indulging in souvenir shopping. Depart from Venice in the afternoon."
  ),
  Event(
    eventID: 8, 
    parentID: 3,
    imageURL: 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=ATJ83zivrblQjYqCnXtaPLQn5765VVVHplevPGywqR7CA2m12yJ4dQgNOFpQHw1sY-vd5MFmkLnoRN4OUj-fqol8f0XNkKcAeRuVF3_J_2EXtYowkgyBfhb7yEC3YkTvEg_dKTRj4cNaTEpZo7McohDbJ4340XpZKVncROjpfJcHqxYWf-WD&key=AIzaSyDQAaDi2Dtvm_qTHVetcZY4LX1UMIeE2yw',
    name: 'The Original Farmers Market',
    lat: '34.0720115',
    long: '-118.3603699', 
    rating: 4.6,
    estStartTime: DateTime(2023, 11, 06, 06, 00),
    category: 'nature',
    description: "Enjoy local cuisine and beverages at this historic market featuring over 100 vendors."
  ),
      Event(
    eventID: 9, 
    parentID: 3,
    imageURL: 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=ATJ83zh9PynnPeAvekjTw2snPtULwRbReurzRXlBxuz9UzMyuw5TvUdWKNj8HOa59YA8xPl-0GU3NfKciZCIhBZVTgPLFXMDFCEJMEBYkj4AN93AWWrjnHlcxEk3p0gwUWn2m25sSh5zi8GW_xNupqxMH9-VToB6_tr1BptllCHm8Hl4X4KC&key=AIzaSyDQAaDi2Dtvm_qTHVetcZY4LX1UMIeE2yw',
    name: 'The Getty Center',
    lat: '34.07803579999999',
    long: '-118.4740954', 
    rating: 4.8,
    estStartTime: DateTime(2023, 11, 06, 11, 30),
    category: 'photography',
    description: "Marvel at European paintings, contemporary photography, and decorative arts at this cultural site."
  ),
      Event(
    eventID: 10, 
    parentID: 3,
    imageURL: 'https://lh5.googleusercontent.com/p/AF1QipMD27bF8x4xJVNRdcbIx6hL5D59KTEsAKMLEtfQ=w535-h240-k-no',
    name: 'Runyon Canyon Park',
    lat: '34.1125932',
    long: '-118.3511659', 
    rating: 4.8,
    estStartTime: DateTime(2023, 11, 06, 21, 30),
    category: 'adventure',
    description: "Experience thrilling outdoor activities with a hike offering panoramic views of Los Angeles",
  ),
      Event(
    eventID: 11, 
    parentID: 3,
    imageURL: "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=ATJ83zgDKHkiBpDToK2SwxGvOfcJhD9RqGzYY5TS4JHU54GQQIwGvr_DRVIjT42ZTghrbMuYhVjRNkaTcCWqs36B2iITVoUqQcbZzxb_Dr19oDQSlSqYnUjC_hzz5QJ0zrblovBZLIxmXEcG_74PufjK_BwcEXsBu2uUATlC-sRbn89qSOeJ&key=AIzaSyDQAaDi2Dtvm_qTHVetcZY4LX1UMIeE2yw",
    name: 'Grand Central Market',
    lat: '34.050872',
    long: '-118.2490552', 
    rating: 4.5,
    estStartTime: DateTime(2023, 11, 06, 21, 30),
    category: 'shopping',
    description: "Taste the diverse flavors of Los Angeles at this bustling food market."
  ),
];