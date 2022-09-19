import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../styles/icon_broken.dart';

Widget defaultButton({
  double wid = double.infinity,
  double r = 100.0,
  required String text,
  bool isUpper = true,
  Color back = Colors.orange,

  required Function function,

}) =>
    Container(
      height: 40,
      width: wid,
      decoration: BoxDecoration(
        color: back,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(r),
bottomLeft: Radius.circular(r),
          topLeft:  Radius.circular(0),
          bottomRight:  Radius.circular(0)
        ),
      ),
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpper ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 2.0,
          ),
        ),

      ),
    );

Widget defaultTextButton({
  required Function function,
  required String text,
}) =>
    TextButton(
      onPressed: () {
        function();
      },
      child: Text(text.toUpperCase()),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  ValueChanged<String>? onSubmit,
  bool isPassword = false,
  IconData? sufix,
  Function? onTap,

  ValueChanged<String>? onChange,
  required String label,
  FormFieldValidator<String>? validate,
  required IconData prefix,
}) =>
    TextFormField(

      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,

      validator: validate,
      // onTap: () {
      //   onTap!();
      // },
      decoration: InputDecoration(
        labelText: label,
        
        border: OutlineInputBorder(borderRadius:BorderRadius.circular(25),
            borderSide:BorderSide(width: 0.2), ),
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: sufix != null
            ? Icon(
                sufix,
              )
            : null,
      ),
    );

Widget defaultAppBar({
  required BuildContext context,
 required String title,
 List<Widget>?actions,

})=> AppBar(
  leading: IconButton(
        onPressed: ()
        {
          Navigator.pop(context);
        },
    icon: Icon(IconBroken.Arrow___Left_2,),
  ),
  title: Text(title),

);

// Widget buildTaskItem(Map model, context) => Dismissible(
//       key: Key(model['id'].toString()),
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Row(
//           children: [
//             CircleAvatar(
//               radius: 40.0,
//               child: Text(
//                 '${model['time']}',
//               ),
//             ),
//             SizedBox(
//               width: 20.0,
//             ),
//             Expanded(
//                 child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   ' ${model['title']}',
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20.0,
//                   ),
//                 ),
//                 Text(
//                   '${model['date']}',
//                   style: const TextStyle(
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             )),
//             SizedBox(
//               width: 20.0,
//             ),
//             IconButton(
//               onPressed: () {
//                 AppCubit.get(context).updateData(
//                   status: 'done',
//                   id: model['id'],
//                 );
//               },
//               icon: Icon(
//                 Icons.check_box,
//                 color: Colors.green[300],
//               ),
//             ),
//             IconButton(
//               onPressed: () {
//                 AppCubit.get(context).updateData(
//                   status: 'Archived',
//                   id: model['id'],
//                 );
//               },
//               icon: const Icon(
//                 Icons.archive,
//                 color: Colors.black54,
//               ),
//             ),
//           ],
//         ),
//       ),
//       onDismissed: (direction) {
//         AppCubit.get(context).deleteDate(
//           id: model['id'],
//         );
//       },
//     );

// Widget tasksBiulder({
//   required List<Map> tasks,
// }) =>
//     ConditionalBuilder(
//       condition: tasks.length > 0,
//       builder: (context) => ListView.separated(
//         itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
//         separatorBuilder: (context, index) => myDivider(),
//         itemCount: tasks.length,
//       ),
//       fallback: (context) => Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.menu,
//               size: 100.0,
//               color: Colors.grey,
//             ),
//             Text(
//               'No Tasks Yet,Please Add Some Tasks',
//               style: TextStyle(
//                 fontSize: 20.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );

// Widget buildArticaleItem(article, context) => InkWell(
//       onTap: () {
//         navigateTo(context, WebViewsScreen(article['url']));
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Row(
//           children: [
//             Container(
//               width: 120.0,
//               height: 120.0,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(
//                   15.0,
//                 ),
//                 image: DecorationImage(
//                   image: NetworkImage('${article['urlToImage']}'),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             SizedBox(
//               width: 20.0,
//             ),
//             Expanded(
//               child: Container(
//                 height: 120.0,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         '${article['title']}',
//                         style: Theme.of(context).textTheme.bodyText1,
//                         maxLines: 3,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     Text(
//                       '${article['publishedAt']}',
//                       style: TextStyle(
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );

Widget myDivider() => Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey[300],
    );

// Widget articleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
//       condition: list.length > 0,
//       builder: (context) => ListView.separated(
//         physics: BouncingScrollPhysics(),
//         itemBuilder: (context, index) =>
//             buildArticaleItem(list[index], context),
//         separatorBuilder: (context, index) => myDivider(),
//         itemCount: 10,
//       ),
//       fallback: (context) => isSearch
//           ? Container()
//           : Center(
//               child: CircularProgressIndicator(),
//             ),
//     );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(
  context,
  widget,
) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (Route<dynamic> route) => false,
    );

void ShowTost({
  required String text,
  required ToastStates states,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(states),
        textColor: Colors.white,
        fontSize: 16.0);
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates states) {
  Color color;
  switch (states) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

