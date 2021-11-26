import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<ProfileModel> profile;
  Future<List<RepoModel>> repos;
  @override
  void initState() {
    super.initState();
    profile = fetchProfile();
    repos = fetchRepo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D1117),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF0D1117),
        centerTitle: true,
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: Colors.white,
              letterSpacing: .5,
              fontSize: 18,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, top: 20, right: 20),
              child: FutureBuilder<ProfileModel>(
                future: profile,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Center(
                      child: Column(
                        children: [
                          Container(
                            height: 180,
                            width: 350,
                            decoration: BoxDecoration(
                              color: Color(0xFF161B22),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, bottom: 8),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    backgroundImage:
                                        NetworkImage(snapshot.data.image),
                                    radius: 30,
                                  ),
                                ),
                                Text(
                                  snapshot.data.name,
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        letterSpacing: .5,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  snapshot.data.company,
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      letterSpacing: .5,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  snapshot.data.bio,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      color: Colors.white70,
                                      letterSpacing: .5,
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Followers',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        color: Colors.white,
                                        letterSpacing: .5,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    snapshot.data.followers.toString(),
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        color: Colors.white,
                                        letterSpacing: .5,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Following',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        color: Colors.white,
                                        letterSpacing: .5,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    snapshot.data.following.toString(),
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        color: Colors.white,
                                        letterSpacing: .5,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Repos',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        color: Colors.white,
                                        letterSpacing: .5,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    snapshot.data.repos.toString(),
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        color: Colors.white,
                                        letterSpacing: .5,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('gagal menampilkan data'));
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                'Repositories',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: Colors.white,
                    letterSpacing: .5,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0, left: 8, right: 8),
              child: FutureBuilder<List<RepoModel>>(
                future: repos,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Color(0xFF161B22),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            title: Text(
                              snapshot.data[index].name,
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: .5,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            subtitle: Text(
                              snapshot.data[index].language,
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('gagal menampilkan data'));
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<ProfileModel> fetchProfile() async {
  String api = 'https://api.github.com/users/alvinzf';
  final response = await http.get(
    Uri.parse(api),
  );

  if (response.statusCode == 200) {
    return ProfileModel.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load profile');
  }
}

Future<List<RepoModel>> fetchRepo() async {
  String api = 'https://api.github.com/users/alvinzf/repos';
  final response = await http.get(
    Uri.parse(api),
  );

  if (response.statusCode == 200) {
    print(response.body);
    var repoJson = jsonDecode(response.body) as List,
        repoShows = repoJson.map((repos) => RepoModel.fromJson(repos)).toList();

    repoShows.removeWhere((repo) =>
        repo.fork == true || repo.private == true || repo.language == null);
    return repoShows;
  } else {
    throw Exception('Failed to load profile');
  }
}

class ProfileModel {
  final String login;
  final int id;
  final String image;
  final int followers;
  final String repo;
  final String name;
  final String company;
  final String blog;
  final String location;
  final String bio;
  final int repos;
  final int following;
  ProfileModel({
    this.login,
    this.id,
    this.image,
    this.followers,
    this.repo,
    this.name,
    this.company,
    this.blog,
    this.location,
    this.bio,
    this.repos,
    this.following,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      login: json['login'],
      id: json['id'],
      image: json['avatar_url'],
      followers: json['followers'],
      repos: json['public_repos'],
      name: json['name'],
      company: json['company'],
      blog: json['blog'],
      location: json['location'],
      bio: json['bio'],
      following: json['following'],
    );
  }
}

class RepoModel {
  final int id;
  final String name;
  final String language;
  final bool fork;
  final bool private;

  RepoModel({this.id, this.name, this.language, this.fork, this.private});

  factory RepoModel.fromJson(Map<String, dynamic> json) {
    return RepoModel(
      id: json['id'],
      name: json['name'],
      language: json['language'],
      fork: json['fork'],
      private: json['private'],
    );
  }
}
