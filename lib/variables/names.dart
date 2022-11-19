import 'dart:math';

List<String> nepalFirstnames = ["Nima", "Nyima", "Yeshe", "Sonam", "Gesar", "Tenzin", "Jinpa", "Tharge"];
List<String> nepalSurnames = ["Caudhari", "Sresth", "Yadav", "Rai", "Thapa", "Magar", "Devi", "Taman", "Tharu",
  "Saha", "Karki", "Kami", "Khadk", "Adhikari", "Khatri", "Gurung", "Khatun", "Maharjan", "Mahato", "Bhandari",
  "Paudel", "Tamang", "Gurun", "Mandal", "Sarki", "Rana", "Sahi", "Ksetri", "Sunar", "Tharuni", "Damai", "Lama",
  "Basnet", "Sarma", "Visvakarm", "Ghimire", "Vika", "Giri", "Limbu", "Budha", "Bhattarai", "Puna", "Acary",
  "Nyaupane", "Nepali", "Pande", "Kesi", "Bohar", "Dahal", "Kurmi", "Vista", "Teli", "Dhami"];

List<String> indianFirstnames = ["Ishaan", "Jai", "Amar", "Navi", "Dhruv", "Kanan", "Diya", "Agastya", "Ananya",
  "Tenzin", "Shaan", "Ajay", "Sahil", "Darsh", "Deven", "Kavi", "Ashwin", "Aadhira", "Raghav", "Avan"];

List<String> indianSurnames = ["Devi", "Singh", "Kumar", "Das", "Kaur", "Ram", "Yadav", "Kumari", "Lal", "Bai",
  "Khatun", "Mandal", "Ali", "Sharma", "Ray", "Mondal", "Khan", "Sah", "Patel", "Prasad", "Patil", "Ghosh", "Pal",
  "Sahu", "Gupta", "Shaikh", "Bibi", "Sekh", "Begam", "Biswas", "Sarkar", "Paramar", "Khatoon", "Mahto", "Ansari",
  "Nayak", "Ma", "Rathod", "Jadhav", "Mahato", "Rani", "Barman", "Behera", "Mishra", "Chand", "Roy",];

String getNepalName() {
  var random = Random();
  var a = nepalFirstnames[random.nextInt(nepalFirstnames.length)];
  var b = nepalSurnames[random.nextInt(nepalSurnames.length)];
  return "$a $b";
}

String getIndianName() {
  var random = Random();
  var a = indianFirstnames[random.nextInt(indianFirstnames.length)];
  var b = indianSurnames[random.nextInt(indianSurnames.length)];
  return "$a $b";
}