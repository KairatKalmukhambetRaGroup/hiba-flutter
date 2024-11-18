part of '../core_library.dart';

/// A custom refresher widget that provides pull-to-refresh functionality.
///
/// The [CustomRefresher] wraps around a child widget and adds a customizable
/// refresh indicator. It uses the [CustomMaterialIndicator] for consistent
/// styling across the app.
///
/// ### Example Usage
/// ```dart
/// CustomRefresher(
///   onRefresh: () async {
///     // Refresh logic here.
///   },
///   child: ListView(
///     children: [/* ... */],
///   ),
/// );
/// ```
class CustomRefresher extends StatefulWidget {
  /// The child widget to be wrapped with the refresh indicator.
  final Widget child;

  /// The callback function to execute when a refresh is triggered.
  final Function onRefresh;

  /// Creates a [CustomRefresher] widget.
  const CustomRefresher({
    super.key,
    required this.child,
    required this.onRefresh,
  });
  @override
  State<StatefulWidget> createState() => _CustomRefresherState();
}

/// The state class for [CustomRefresher].
///
/// Manages the state of the refresh indicator and handles the refresh logic.
class _CustomRefresherState extends State<CustomRefresher>
    with SingleTickerProviderStateMixin {
  bool _renderCompleteState = false;

  ScrollDirection prevScrollDirection = ScrollDirection.idle;

  @override
  Widget build(BuildContext context) {
    return CustomMaterialIndicator(
      displacement: 50,
      onRefresh: () => widget.onRefresh(),
      durations: const RefreshIndicatorDurations(
        completeDuration: Duration(seconds: 2),
      ),
      onStateChanged: (change) {
        /// set [_renderCompleteState] to true when controller.state become completed
        if (change.didChange(to: IndicatorState.complete)) {
          _renderCompleteState = true;

          /// set [_renderCompleteState] to false when controller.state become idle
        } else if (change.didChange(to: IndicatorState.idle)) {
          _renderCompleteState = false;
        }
      },
      indicatorBuilder: (
        BuildContext context,
        IndicatorController controller,
      ) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: AppColors.mainBlue,
            shape: BoxShape.circle,
          ),
          child: _renderCompleteState
              ? const Icon(
                  Icons.check,
                  color: Colors.white,
                )
              : SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.white,
                    value: controller.isDragging || controller.isArmed
                        ? controller.value.clamp(0.0, 1.0)
                        : null,
                  ),
                ),
        );
      },
      child: widget.child,
    );
  }
}
