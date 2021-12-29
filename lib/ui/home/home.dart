import 'dart:math';

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/models/movie/top_rate_response.dart';
import 'package:boilerplate/stores/movie/movie_store.dart';
import 'package:boilerplate/ui/detail/movie_detail.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:boilerplate/stores/language/language_store.dart';
import 'package:boilerplate/stores/post/post_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/utils/utils.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:material_dialog/material_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _controller = PageController(initialPage: 0);
  static const _kDuration = const Duration(milliseconds: 300);
  final _formKey = GlobalKey<FormState>();
  static const _kCurve = Curves.ease;

  //text controllers:-----------------------------------------------------------
  TextEditingController _minYearController = TextEditingController();
  TextEditingController _maxYearController = TextEditingController();

  //stores:---------------------------------------------------------------------
  late PostStore _postStore;
  late MovieStore _movieStore;
  late ThemeStore _themeStore;
  late LanguageStore _languageStore;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // initializing stores
    _languageStore = Provider.of<LanguageStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
    _postStore = Provider.of<PostStore>(context);
    _movieStore = Provider.of<MovieStore>(context);

    if (!_movieStore.loading) {
      _movieStore.getTopRateMovie();
      _movieStore.getMoviePlaying();
      _movieStore.getMovieUpcoming();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: Colors.black,
      body: _buildBody(),
    );
  }

  // app bar methods:-----------------------------------------------------------
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(AppLocalizations.of(context).translate('home_tv_posts')),
      actions: _buildActions(context),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    return <Widget>[
      _buildLanguageButton(),
      _buildThemeButton(),
      _buildLogoutButton(),
    ];
  }

  Widget _buildThemeButton() {
    return Observer(
      builder: (context) {
        return IconButton(
          onPressed: () {
            _themeStore.changeBrightnessToDark(!_themeStore.darkMode);
          },
          icon: Icon(
            _themeStore.darkMode ? Icons.brightness_5 : Icons.brightness_3,
          ),
        );
      },
    );
  }

  Widget _buildLogoutButton() {
    return IconButton(
      onPressed: () {
        SharedPreferences.getInstance().then((preference) {
          preference.setBool(Preferences.is_logged_in, false);
          Navigator.of(context).pushReplacementNamed(Routes.login);
        });
      },
      icon: Icon(
        Icons.power_settings_new,
      ),
    );
  }

  Widget _buildLanguageButton() {
    return IconButton(
      onPressed: () {
        _buildLanguageDialog();
      },
      icon: Icon(
        Icons.language,
      ),
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        _handleErrorMessage(),
        _buildMainContent(),
      ],
    );
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return _movieStore.loading || _movieStore.filtered
            ? CustomProgressIndicatorWidget()
            : Material(child: _buildListView());
      },
    );
  }

  Widget _buildListView() {
    return _movieStore.movieList != null || _movieStore.moviePlayingList != null|| _movieStore.movieUpComingList != null
        ? SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: <Widget>[
                    SizedBox(
                      height: 250.0,
                      width: double.infinity,
                      child: Container(
                        color: Colors.grey,
                        child: PageView(
                          controller: _controller,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/ic_films.jpeg',
                              width: double.infinity,
                              height: 250.0,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    "https://h3f6a6h4.rocketcdn.me/wp-content/uploads/2021/08/Spider-Man-No-Way-Home-Trailer-Release-Update.jpg",
                                  ),
                                  fit: BoxFit.cover,
                                ),
//                      color: Colors.grey,
                              ),
                            ),
                            Image.asset(
                              'assets/images/ic_films.jpeg',
                              width: double.infinity,
                              height: 250.0,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                    ),
                    new Container(
//                  color: Colors.grey[800].withOpacity(0.3),
                      padding: const EdgeInsets.all(20.0),
                      child: new DotsIndicator(
                        controller: _controller,
                        itemCount: 3,
                        onPageSelected: (int page) {
                          _controller.animateToPage(
                            page,
                            duration: _kDuration,
                            curve: _kCurve,
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(16.0, 4.0, 0, 0),
                        child: Text(
                          "SPIDER-MAN: NO WAY HOME",
                          style: TextStyle(
                              fontSize: 26.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(16.0, 0, 0, 0.0),
                        child: Text(
                          "SUẤT CHIẾU SỚM",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.yellow,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 0.0, 0, 0.0),
                      child: Text(
                        "Hành Động",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontStyle: FontStyle.normal),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(" ",
                          style: TextStyle(
                            backgroundColor: Colors.white,
                            fontSize: 10.0,
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        "2D",
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.white,
                            fontStyle: FontStyle.normal),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(" ",
                          style: TextStyle(
                            backgroundColor: Colors.white,
                            fontSize: 10,
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        "20h20p",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontStyle: FontStyle.normal),
                      ),
                    ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.fromLTRB(30.0, 0.0, 16.0, 0),
                      padding: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(
                              24.0)), // set rounded corner radius
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10.0,
                                color: Colors.black,
                                offset: Offset(1, 3))
                          ] // make rounded corner of border
                          ),
                      child: Text("Đặt Vé",
                          style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.white,
                              fontStyle: FontStyle.normal)),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 24.0, 0, 4.0),
                      child: Text(
                        "Top Rate",
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal),
                      ),
                    ),
                    Spacer(),
                    Padding(
                        padding: EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            new GestureDetector(
                              onTap: () {
                                showDialogFilter();
                              },
                              child: Text(
                                "Filters",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    decoration: TextDecoration.underline,
                                    color: Colors.cyan,
                                    fontStyle: FontStyle.normal),
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              "Tất Cả",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  decoration: TextDecoration.underline,
                                  color: Colors.cyan,
                                  fontStyle: FontStyle.normal),
                            ),
                          ],
                        )),
                  ],
                ),
                SizedBox(height: 300.0, child: buildListMovieTopRateWidget()),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 24.0, 0, 4.0),
                      child: Text(
                        "Phim đang chiếu",
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 4.0),
                      child: Text(
                        "Tất Cả",
                        style: TextStyle(
                            fontSize: 16.0,
                            decoration: TextDecoration.underline,
                            color: Colors.cyan,
                            fontStyle: FontStyle.normal),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 200.0, child: buildListMoviePlayingWidget()),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 24.0, 0, 4.0),
                      child: Text(
                        "Phim sắp chiếu",
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 4.0),
                      child: Text(
                        "Tất Cả",
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.cyan,
                            decoration: TextDecoration.underline,
                            fontStyle: FontStyle.normal),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                  child: SizedBox(
                      height: 200.0, child: buildListMovieUpComingWidget()),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 24.0, 0, 4.0),
                    child: Text(
                      "Phim đặc biệt (4D/IMAX/STARIUM)",
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                  child: SizedBox(height: 200.0, child: buildListViewWidget()),
                ),
              ],
            ),
          )
        : Center(
            child: Text(
              AppLocalizations.of(context).translate('home_tv_no_post_found'),
            ),
          );
  }

  Widget buildListMovieTopRateWidget() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _movieStore.movieList!.length,
        itemExtent: 180.0,
        itemBuilder: (context, position) {
          return GestureDetector(
            onTap: () {
              handleOpenYoutube(_movieStore.movieList!, position);
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
              child: ClipPath(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Card(
                        elevation: 10.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(6.0),
                          ),
                        ),
                        child: ClipPath(
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  Utils.loadedPathImage(_movieStore
                                          .movieList![position].posterPath ??
                                      ""),
                                ),
                                fit: BoxFit.cover,
                              ),
//                      color: Colors.grey,
                            ),
                          ),
                          clipper: ShapeBorderClipper(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.0))),
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(_movieStore.movieList![position].title ?? "",
                          overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget buildListMoviePlayingWidget() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _movieStore.moviePlayingList!.length,
        itemExtent: 300.0,
        itemBuilder: (context, position) {
          return GestureDetector(
            onTap: () {
              handleOpenYoutube(_movieStore.moviePlayingList!, position);
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
              child: Card(
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(6.0),
                  ),
                ),
                child: ClipPath(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                Utils.loadedPathImage(_movieStore
                                        .moviePlayingList![position]
                                        .posterPath ??
                                    ""),
                              ),
                              fit: BoxFit.cover,
                            ),
//                      color: Colors.grey,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                            _movieStore.moviePlayingList![position].title ?? "",
                            overflow: TextOverflow.ellipsis),
                        subtitle: Text(
                          "Ngày chiếu : ${_movieStore.moviePlayingList![position].releaseDate ?? ""}",
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Icon(
                          Icons.bookmark,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  clipper: ShapeBorderClipper(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0))),
                ),
              ),
            ),
          );
        });
  }

  Widget buildListMovieUpComingWidget() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _movieStore.movieUpComingList!.length,
        itemExtent: 200.0,
        itemBuilder: (context, position) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
            child: Card(
              elevation: 10.0,
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(6.0),
                ),
              ),
              child: ClipPath(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              Utils.loadedPathImage(
                                  _movieStore.movieUpComingList![position].posterPath ??
                                      ""),
                            ),
                            fit: BoxFit.fill,
//                        colorFilter: ColorFilter.mode(
//                          Colors.black26,
//                          BlendMode.darken,
//                        ),
                          ),
//                      color: Colors.grey,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(_movieStore.movieUpComingList![position].title ?? "",
                          overflow: TextOverflow.ellipsis),
                      subtitle: Text(
                        _movieStore.movieUpComingList![position].releaseDate ?? "",
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Icon(
                        Icons.book,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                clipper: ShapeBorderClipper(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0))),
              ),
            ),
          );
        });
  }

  Widget buildListViewWidget() {
    return _movieStore.movieList != null
        ? ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _movieStore.movieList!.length,
            itemExtent: 150.0,
            itemBuilder: (context, position) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                child: ClipPath(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: ClipOval(
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  Utils.loadedPathImage(_movieStore
                                          .movieList![position].posterPath ??
                                      ""),
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                          title: Center(
                        child: Text(
                          _movieStore.movieList![position].title ?? "",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal),
                        ),
                      )),
                    ],
                  ),
                ),
              );
            })
        : Center(
            child: Text(
              AppLocalizations.of(context).translate('home_tv_no_movie_found'),
            ),
          );
  }

  Widget _buildListItem(int position) {
    return ListTile(
      dense: true,
      leading: Icon(Icons.cloud_circle),
      title: Text(
        '${_postStore.postList?.posts?[position].title}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      subtitle: Text(
        '${_postStore.postList?.posts?[position].body}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
      ),
    );
  }

  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        if (_movieStore.errorStore.errorMessage.isNotEmpty) {
          return _showErrorMessage(_movieStore.errorStore.errorMessage);
        }

        return SizedBox.shrink();
      },
    );
  }

  // General Methods:-----------------------------------------------------------
  _showErrorMessage(String message) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message.isNotEmpty) {
        FlushbarHelper.createError(
          message: message,
          title: AppLocalizations.of(context).translate('home_tv_error'),
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });

    return SizedBox.shrink();
  }

  _buildLanguageDialog() {
    _showDialog<String>(
      context: context,
      child: MaterialDialog(
        borderRadius: 5.0,
        enableFullWidth: true,
        title: Text(
          AppLocalizations.of(context).translate('home_tv_choose_language'),
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        headerColor: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        closeButtonColor: Colors.white,
        enableCloseButton: true,
        enableBackButton: false,
        onCloseButtonClicked: () {
          Navigator.of(context).pop();
        },
        children: _languageStore.supportedLanguages
            .map(
              (object) => ListTile(
                dense: true,
                contentPadding: EdgeInsets.all(0.0),
                title: Text(
                  object.language!,
                  style: TextStyle(
                    color: _languageStore.locale == object.locale
                        ? Theme.of(context).primaryColor
                        : _themeStore.darkMode
                            ? Colors.white
                            : Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  // change user language based on selected locale
                  _languageStore.changeLanguage(object.locale!);
                },
              ),
            )
            .toList(),
      ),
    );
  }

  _showDialog<T>({required BuildContext context, required Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T? value) {
      // The value passed to Navigator.pop() or null.
    });
  }

  void showDialogFilter() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  right: -40.0,
                  top: -40.0,
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.close),
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        height: 14.0,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _minYearController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Min Year",
                            counterText: '',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _maxYearController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Max Year",
                            counterText: '',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          child: Text("Apply"),
                          onPressed: () {
                            handleFilter();
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _minYearController.dispose();
    _maxYearController.dispose();
    super.dispose();
  }

  void handleFilter() {
    Navigator.of(context).pop();
    if (_minYearController.text.isEmpty || _maxYearController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("You need to enter all the information."),
      ));
      return;
    }
    _movieStore.filterTopRateMovie(
        int.parse(_minYearController.text), int.parse(_maxYearController.text));
  }

  Future<void> handleOpenYoutube(List<Movie> movieList, int position) async {
    Navigator.pushNamed(context, MovieDetailScreen.detail, arguments: movieList[position]);
  }
}

class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    required this.controller,
    required this.itemCount,
    required this.onPageSelected,
    this.color: Colors.white,
  }) : super(listenable: controller);

  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final int itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int> onPageSelected;

  /// The color of the dots.
  ///
  /// Defaults to `Colors.white`.
  final Color color;

  // The base size of the dots
  static const double _kDotSize = 8.0;

  // The increase in the size of the selected dot
  static const double _kMaxZoom = 2.0;

  // The distance between the center of each dot
  static const double _kDotSpacing = 25.0;

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;
    return new Container(
      width: _kDotSpacing,
      child: new Material(
        color: color,
        type: MaterialType.circle,
        child: new Container(
          width: _kDotSize * zoom,
          height: _kDotSize * zoom,
          child: new InkWell(
            onTap: () => onPageSelected(index),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, _buildDot),
    );
  }
}
