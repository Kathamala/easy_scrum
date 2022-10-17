// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //List<Project> projects = new List<Project>;
  //List<Project> meetings = new List<Meeting>;

  @override
  void initState() {
    super.initState();
    //load projects...
    //load meetings...
  }

  void openProject(int projectId){
    print("Opening project " + projectId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Home", style: TextStyle(
                                color: AppColors.black, fontSize: 18, fontWeight: FontWeight.bold)),
          centerTitle: true,
      ),
      body: Column(
        children: [
          Card(
            elevation: 4.0,
            child: Column(
              Text("Projetos", style: TextStyle(
                color: AppColors.primaryPurple,
                fontSize: 14,
                fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              /*
              for(Project p : projects){
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      openProject(p.id);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      primary: AppColors.secondaryGrey,
                      fixedSize: Size(250, 60),
                      shape: StadiumBorder()),
                  child: const Text(
                    p.name,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )
                ),         
                SizedBox(height: 10),       
              }*/
            )
          ),
        ]
      )
    );
  }
}
