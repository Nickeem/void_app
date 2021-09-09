import 'constraints.dart';
import 'package:flutter/material.dart';
import 'package:helpers/helpers.dart';
import 'CustomContainer.dart';
import 'package:void_app/MatchPage.dart';
import 'package:void_app/MatchMisc.dart';


class MatchCard extends StatelessWidget {
  const MatchCard(this.match, {Key? key}) : super(key: key);

  final Match match;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      height: double.infinity,
      child: ClipRRect(
        borderRadius: kAllBorderRadius,
        child: AspectRatio(
          aspectRatio: kCardAspectRatio,
          child: Stack(children: [
            Positioned.fill(child: MatchImage(match)),
            SplashTap(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MatchPage(match)),
              ),
              child: Container(color: Colors.transparent),
            ),
            Padding(padding: kAllPadding, child: MatchTitle(match)),
            /*Padding(
              padding: kAllPadding,
              child: Align(
                alignment: Alignment.topRight,
                child: MovieFavoriteIcon(movie),
              ),
            ),*/
          ]),
        ),
      ),
    );
  }
}

class MatchCardSlider extends StatefulWidget {
  const MatchCardSlider(this.matches, {Key? key}) : super(key: key);

  final List<Match> matches;

  @override
  _MatchCardSliderState createState() => _MatchCardSliderState();
}

class _MatchCardSliderState extends State<MatchCardSlider> {
  late PageController _pageController = PageController();
  Size lastSize = Size.zero;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    Misc.onLayoutRendered(() => setState(_updateDimension));
    super.initState();
  }

  void _updateDimension([Size? size]) {
    final double width = size?.width ?? context.media.width;
    _pageController = PageController(
      viewportFraction: (width - kSectionPadding * 2) / width,
    );
  }

  @override
  Widget build(BuildContext context) {
    const Curve curve = Curves.ease;
    const double minScale = 0.6;


    return AspectRatio(
      aspectRatio: kCardAspectRatio,
      child: LayoutBuilder(builder: (_, constraints){
        final Size size = constraints.biggest;
        if (lastSize != size) {
          lastSize = size;
          _updateDimension(size);
        }
        return PageView.builder(
          itemCount: widget.matches.length,
          clipBehavior: Clip.none,
          scrollDirection: Axis.horizontal,
          controller: _pageController,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (_, int index) => AnimatedBuilder(
            animation: _pageController,
            builder: (_, child) {
              double itemOffset = 0.0;
              try {
                itemOffset = (_pageController.page ?? 0.0) - index;
              } catch (_) {
                itemOffset = 0.0;
              }
              final double distortionValue = curve.transform(
                (1 - (itemOffset.abs() * (1 - minScale)))
                    .clamp(0.0, 1.0)
                    .toDouble(),
              );
              return Transform.scale(
                scale: distortionValue,
                child: Align(
                  alignment: Alignment(
                    curve.transform(itemOffset.abs().clamp(0.0, 1.0)),
                    0.0,
                  ),
                  child: SizedBox(
                    height: distortionValue * size.height,
                    width: size.width,
                    child: child,
                  ),
                ),
              );
            },
            child: MatchCard(widget.matches[index]),
          ),
        );

      }),
    );
  }
}