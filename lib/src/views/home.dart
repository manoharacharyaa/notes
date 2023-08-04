import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/src/res/strings.dart';
import 'package:notes_app/src/services/local_db.dart';
import 'package:notes_app/src/views/create_note.dart';
import 'package:notes_app/src/views/widgets/empty_view.dart';
import 'package:notes_app/src/views/widgets/notes_grid.dart';
import 'package:notes_app/src/views/widgets/notes_list.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isListView = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.appName,
                    style: GoogleFonts.poppins(fontSize: 24),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isListView = !isListView;
                      });
                    },
                    icon: Icon(
                      isListView ? Icons.splitscreen_outlined : Icons.grid_view,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: LocalDBService().listenAllNotes(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return const EmptyView();
                  }
                  final notes = snapshot.data!;

                  return AnimatedSwitcher(
                    duration: const Duration(microseconds: 300),
                    child: isListView
                        ? NotesList(notes: notes)
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: NotesGrid(notes: notes),
                          ),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const CreateNoteView(),
              ),
            );
          },
          backgroundColor: Colors.white,
          child: const Icon(
            Icons.add,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
