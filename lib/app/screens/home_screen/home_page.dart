import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<ContestRound> contestRounds = [
    ContestRound(
        name: 'Qualifying',
        date: [DateTime(2023, 3, 10), DateTime(2023, 3, 10)], subtitle: 'This is the subtitle for this task and now just have to submit the code to the github and write the readme file. So just doing and then submitting the assignment to internshala chat window for review'),
    ContestRound(name: 'Quarterfinals', date: [DateTime(2023, 3, 12)], subtitle: 'Hello this is the subtitle'),
    ContestRound(name: 'Semifinals', date: [DateTime(2023, 3, 15)], subtitle: 'Hello this is the subtitle'),
    ContestRound(name: 'Finals', date: [DateTime(2023, 3, 18)],subtitle: 'Hello this is the subtitle'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contest Schedule',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: contestRounds.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                ContestRound round = contestRounds[index];
                bool isLast = index == contestRounds.length - 1;
                return TimelineTile(
                  title: round.name,
                  isLast: isLast,
                  dateList: round.date,
                  subtitle: round.subtitle,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ContestRound {
  final String name;
  final String subtitle;
  final List<DateTime> date;


  ContestRound({required this.name, required this.date, required this.subtitle});
}

class TimelineTile extends StatelessWidget {
  final String title;
  final bool isLast;
  final String subtitle;
  final List<DateTime> dateList;

  const TimelineTile({
    Key? key,
    required this.title,
    required this.dateList,
    required this.subtitle,
    this.isLast = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadiusDirectional.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${dateList[0].day}th',
                style: const TextStyle(color: Colors.white),
              ),
              const Text(
                'Nov',
                style: TextStyle(color: Colors.white),
              ),
              dateList.length != 1
                  ? Column(
                      children: [
                        const SizedBox(
                          height: 7,
                        ),
                        Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          width: 2,
                          height: isLast ? 0 : 70,
                          color: Colors.grey[300],
                        ),
                        Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                      ],
                    )
                  : Container(),
              dateList.length != 1
                  ? Column(
                      children: [
                        Text(
                          '${dateList[1].day}th',
                          style: const TextStyle(color: Colors.white),
                        ),
                        const Text(
                          'Nov',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: 20),
            constraints:
                BoxConstraints(minHeight: dateList.length != 1 ? 170 : 0),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: 290,
            decoration: BoxDecoration(
                color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(height: 5,),
                Text(
                  subtitle,
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
