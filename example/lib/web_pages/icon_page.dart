import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

class IconPage extends StatelessWidget {
  const IconPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(color: SBBColors.white),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 48.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SBBWebText.headerOne('Icons', color: SBBColors.red),
              SBBWebText.headerTwo('Ausprägungen'),
              SBBWebText.headerThree('- Small'),
              _IconGriedView(iconSize: 24.0, icons: iconsSmall),
              SBBWebText.headerThree('- Medium'),
              _IconGriedView(iconSize: 36.0, icons: iconsMedium),
              SBBWebText.headerThree('- Large'),
              _IconGriedView(iconSize: 48.0, icons: iconsLarge),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconGriedView extends StatelessWidget {
  const _IconGriedView({Key? key, required this.iconSize, required this.icons})
      : super(key: key);

  final double iconSize;
  final List<Map<String, Object>> icons;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SizedBox(
        height: 200.0,
        child: GridView.builder(
          controller: ScrollController(),
          physics: PageScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: iconSize + sbbDefaultSpacing,
          ),
          itemCount: icons.length,
          itemBuilder: (BuildContext context, index) {
            final icon = icons[index];
            return IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                icon['icon'] as IconData,
                size: iconSize,
              ),
              onPressed: () {
                SBBToast.of(context).show(message: icon['name'] as String);
              },
            );
          },
        ),
      ),
    );
  }
}

const iconsSmall = [
  {'icon': SBBIcons.aerosol_can_small, 'name': 'aerosol_can_small'},
  {'icon': SBBIcons.airplane_small, 'name': 'airplane_small'},
  {'icon': SBBIcons.alarm_clock_small, 'name': 'alarm_clock_small'},
  {'icon': SBBIcons.app_icon_small, 'name': 'app_icon_small'},
  {'icon': SBBIcons.apple_bag_small, 'name': 'apple_bag_small'},
  {'icon': SBBIcons.archive_box_small, 'name': 'archive_box_small'},
  {
    'icon': SBBIcons.armchair_profile_user_small,
    'name': 'armchair_profile_user_small'
  },
  {'icon': SBBIcons.armchair_small, 'name': 'armchair_small'},
  {
    'icon': SBBIcons.arrow_change_horizontal_small,
    'name': 'arrow_change_horizontal_small'
  },
  {'icon': SBBIcons.arrow_change_small, 'name': 'arrow_change_small'},
  {'icon': SBBIcons.arrow_circle_eye_small, 'name': 'arrow_circle_eye_small'},
  {
    'icon': SBBIcons.arrow_circle_lightning_small,
    'name': 'arrow_circle_lightning_small'
  },
  {'icon': SBBIcons.arrow_circle_small, 'name': 'arrow_circle_small'},
  {
    'icon': SBBIcons.arrow_circle_switzerland_small,
    'name': 'arrow_circle_switzerland_small'
  },
  {
    'icon': SBBIcons.arrow_circle_train_tracks_small,
    'name': 'arrow_circle_train_tracks_small'
  },
  {
    'icon': SBBIcons.arrow_circle_two_users_small,
    'name': 'arrow_circle_two_users_small'
  },
  {'icon': SBBIcons.arrow_compass_small, 'name': 'arrow_compass_small'},
  {'icon': SBBIcons.arrow_down_small, 'name': 'arrow_down_small'},
  {'icon': SBBIcons.arrow_long_left_small, 'name': 'arrow_long_left_small'},
  {'icon': SBBIcons.arrow_long_right_small, 'name': 'arrow_long_right_small'},
  {'icon': SBBIcons.arrow_right_small, 'name': 'arrow_right_small'},
  {'icon': SBBIcons.arrows_circle_small, 'name': 'arrows_circle_small'},
  {
    'icon': SBBIcons.arrows_left_right_down_up_small,
    'name': 'arrows_left_right_down_up_small'
  },
  {'icon': SBBIcons.arrows_left_right_small, 'name': 'arrows_left_right_small'},
  {'icon': SBBIcons.arrows_right_left_small, 'name': 'arrows_right_left_small'},
  {'icon': SBBIcons.arrows_up_down_small, 'name': 'arrows_up_down_small'},
  {'icon': SBBIcons.avatar_police_small, 'name': 'avatar_police_small'},
  {
    'icon': SBBIcons.avatar_train_staff_disabled_small,
    'name': 'avatar_train_staff_disabled_small'
  },
  {
    'icon': SBBIcons.avatar_train_staff_small,
    'name': 'avatar_train_staff_small'
  },
  {'icon': SBBIcons.backpack_small, 'name': 'backpack_small'},
  {'icon': SBBIcons.banknotes_dollar_small, 'name': 'banknotes_dollar_small'},
  {
    'icon': SBBIcons.barrier_construction_small,
    'name': 'barrier_construction_small'
  },
  {
    'icon': SBBIcons.battery_level_empty_small,
    'name': 'battery_level_empty_small'
  },
  {
    'icon': SBBIcons.battery_level_high_small,
    'name': 'battery_level_high_small'
  },
  {'icon': SBBIcons.battery_level_low_small, 'name': 'battery_level_low_small'},
  {
    'icon': SBBIcons.battery_level_medium_small,
    'name': 'battery_level_medium_small'
  },
  {'icon': SBBIcons.bell_disabled_small, 'name': 'bell_disabled_small'},
  {'icon': SBBIcons.bell_small, 'name': 'bell_small'},
  {
    'icon': SBBIcons.bicycle_profile_user_group_circle_small,
    'name': 'bicycle_profile_user_group_circle_small'
  },
  {'icon': SBBIcons.bicycle_small, 'name': 'bicycle_small'},
  {
    'icon': SBBIcons.bike_profile_power_plug_small,
    'name': 'bike_profile_power_plug_small'
  },
  {
    'icon': SBBIcons.bike_profile_sign_parking_small,
    'name': 'bike_profile_sign_parking_small'
  },
  {'icon': SBBIcons.binoculars_small, 'name': 'binoculars_small'},
  {
    'icon': SBBIcons.bluetooth_disabled_small,
    'name': 'bluetooth_disabled_small'
  },
  {'icon': SBBIcons.bluetooth_small, 'name': 'bluetooth_small'},
  {'icon': SBBIcons.boat_profile_small, 'name': 'boat_profile_small'},
  {'icon': SBBIcons.book_section_mark_small, 'name': 'book_section_mark_small'},
  {'icon': SBBIcons.book_small, 'name': 'book_small'},
  {'icon': SBBIcons.bottle_apple_small, 'name': 'bottle_apple_small'},
  {'icon': SBBIcons.briefcase_small, 'name': 'briefcase_small'},
  {'icon': SBBIcons.brochure_small, 'name': 'brochure_small'},
  {'icon': SBBIcons.browser_small, 'name': 'browser_small'},
  {'icon': SBBIcons.bucket_foam_broom_small, 'name': 'bucket_foam_broom_small'},
  {'icon': SBBIcons.building_tree_small, 'name': 'building_tree_small'},
  {'icon': SBBIcons.bulb_off_small, 'name': 'bulb_off_small'},
  {'icon': SBBIcons.bulb_on_small, 'name': 'bulb_on_small'},
  {'icon': SBBIcons.bus_profile_small, 'name': 'bus_profile_small'},
  {'icon': SBBIcons.bus_sbb_small, 'name': 'bus_sbb_small'},
  {'icon': SBBIcons.bus_small, 'name': 'bus_small'},
  {'icon': SBBIcons.bus_stop_small, 'name': 'bus_stop_small'},
  {
    'icon': SBBIcons.bus_surrounding_area_small,
    'name': 'bus_surrounding_area_small'
  },
  {'icon': SBBIcons.button_power_small, 'name': 'button_power_small'},
  {'icon': SBBIcons.cable_car_profile_small, 'name': 'cable_car_profile_small'},
  {'icon': SBBIcons.calculator_small, 'name': 'calculator_small'},
  {'icon': SBBIcons.calendar_one_day_small, 'name': 'calendar_one_day_small'},
  {'icon': SBBIcons.calendar_small, 'name': 'calendar_small'},
  {'icon': SBBIcons.camera_small, 'name': 'camera_small'},
  {'icon': SBBIcons.car_power_plug_small, 'name': 'car_power_plug_small'},
  {
    'icon': SBBIcons.car_profile_power_plug_small,
    'name': 'car_profile_power_plug_small'
  },
  {
    'icon': SBBIcons.car_profile_sign_parking_small,
    'name': 'car_profile_sign_parking_small'
  },
  {'icon': SBBIcons.car_profile_small, 'name': 'car_profile_small'},
  {
    'icon': SBBIcons.car_profile_user_group_circle_small,
    'name': 'car_profile_user_group_circle_small'
  },
  {'icon': SBBIcons.car_sign_parking_small, 'name': 'car_sign_parking_small'},
  {'icon': SBBIcons.car_small, 'name': 'car_small'},
  {'icon': SBBIcons.cash_register_small, 'name': 'cash_register_small'},
  {
    'icon': SBBIcons.certificate_ribbon_small,
    'name': 'certificate_ribbon_small'
  },
  {
    'icon': SBBIcons.certificate_ribbon_tick_small,
    'name': 'certificate_ribbon_tick_small'
  },
  {'icon': SBBIcons.chairlift_profile_small, 'name': 'chairlift_profile_small'},
  {'icon': SBBIcons.charging_station_small, 'name': 'charging_station_small'},
  {'icon': SBBIcons.chart_column_small, 'name': 'chart_column_small'},
  {
    'icon': SBBIcons.chart_column_trend_small,
    'name': 'chart_column_trend_small'
  },
  {'icon': SBBIcons.chart_line_small, 'name': 'chart_line_small'},
  {'icon': SBBIcons.chart_pie_small, 'name': 'chart_pie_small'},
  {'icon': SBBIcons.chevron_left_small, 'name': 'chevron_left_small'},
  {'icon': SBBIcons.chevron_right_small, 'name': 'chevron_right_small'},
  {
    'icon': SBBIcons.chevron_small_down_circle_small,
    'name': 'chevron_small_down_circle_small'
  },
  {
    'icon': SBBIcons.chevron_small_down_small,
    'name': 'chevron_small_down_small'
  },
  {
    'icon': SBBIcons.chevron_small_left_circle_small,
    'name': 'chevron_small_left_circle_small'
  },
  {
    'icon': SBBIcons.chevron_small_left_small,
    'name': 'chevron_small_left_small'
  },
  {
    'icon': SBBIcons.chevron_small_right_circle_small,
    'name': 'chevron_small_right_circle_small'
  },
  {
    'icon': SBBIcons.chevron_small_right_small,
    'name': 'chevron_small_right_small'
  },
  {
    'icon': SBBIcons.chevron_small_up_circle_small,
    'name': 'chevron_small_up_circle_small'
  },
  {'icon': SBBIcons.chevron_small_up_small, 'name': 'chevron_small_up_small'},
  {'icon': SBBIcons.child_adult_small, 'name': 'child_adult_small'},
  {
    'icon': SBBIcons.cigarette_disabled_small,
    'name': 'cigarette_disabled_small'
  },
  {'icon': SBBIcons.cigarette_small, 'name': 'cigarette_small'},
  {'icon': SBBIcons.circle_cross_small, 'name': 'circle_cross_small'},
  {
    'icon': SBBIcons.circle_information_small,
    'name': 'circle_information_small'
  },
  {
    'icon': SBBIcons.circle_information_small_small,
    'name': 'circle_information_small_small'
  },
  {'icon': SBBIcons.circle_minus_small, 'name': 'circle_minus_small'},
  {'icon': SBBIcons.circle_play_small, 'name': 'circle_play_small'},
  {'icon': SBBIcons.circle_plus_small, 'name': 'circle_plus_small'},
  {
    'icon': SBBIcons.circle_question_mark_small,
    'name': 'circle_question_mark_small'
  },
  {'icon': SBBIcons.circle_tick_small, 'name': 'circle_tick_small'},
  {
    'icon': SBBIcons.circle_triangle_square_small,
    'name': 'circle_triangle_square_small'
  },
  {'icon': SBBIcons.city_small, 'name': 'city_small'},
  {'icon': SBBIcons.clapperboard_small, 'name': 'clapperboard_small'},
  {'icon': SBBIcons.clipboard_cross_small, 'name': 'clipboard_cross_small'},
  {
    'icon': SBBIcons.clipboard_question_mark_small,
    'name': 'clipboard_question_mark_small'
  },
  {'icon': SBBIcons.clipboard_tick_small, 'name': 'clipboard_tick_small'},
  {'icon': SBBIcons.clock_small, 'name': 'clock_small'},
  {'icon': SBBIcons.cloud_dense_fog_small, 'name': 'cloud_dense_fog_small'},
  {'icon': SBBIcons.cloud_drops_moon_small, 'name': 'cloud_drops_moon_small'},
  {'icon': SBBIcons.cloud_drops_small, 'name': 'cloud_drops_small'},
  {'icon': SBBIcons.cloud_fog_small, 'name': 'cloud_fog_small'},
  {'icon': SBBIcons.cloud_ice_small, 'name': 'cloud_ice_small'},
  {
    'icon': SBBIcons.cloud_lightning_moon_small,
    'name': 'cloud_lightning_moon_small'
  },
  {'icon': SBBIcons.cloud_lightning_small, 'name': 'cloud_lightning_small'},
  {
    'icon': SBBIcons.cloud_little_snow_moon_small,
    'name': 'cloud_little_snow_moon_small'
  },
  {
    'icon': SBBIcons.cloud_little_snow_sun_small,
    'name': 'cloud_little_snow_sun_small'
  },
  {'icon': SBBIcons.cloud_moon_small, 'name': 'cloud_moon_small'},
  {'icon': SBBIcons.cloud_rain_small, 'name': 'cloud_rain_small'},
  {
    'icon': SBBIcons.cloud_rain_snow_moon_small,
    'name': 'cloud_rain_snow_moon_small'
  },
  {'icon': SBBIcons.cloud_rain_snow_small, 'name': 'cloud_rain_snow_small'},
  {
    'icon': SBBIcons.cloud_rain_snow_sun_small,
    'name': 'cloud_rain_snow_sun_small'
  },
  {'icon': SBBIcons.cloud_rain_sun_small, 'name': 'cloud_rain_sun_small'},
  {'icon': SBBIcons.cloud_small, 'name': 'cloud_small'},
  {
    'icon': SBBIcons.cloud_snow_lightning_small,
    'name': 'cloud_snow_lightning_small'
  },
  {'icon': SBBIcons.cloud_snow_moon_small, 'name': 'cloud_snow_moon_small'},
  {'icon': SBBIcons.cloud_snow_small, 'name': 'cloud_snow_small'},
  {'icon': SBBIcons.cloud_snow_sun_small, 'name': 'cloud_snow_sun_small'},
  {'icon': SBBIcons.cloud_snowflake_small, 'name': 'cloud_snowflake_small'},
  {
    'icon': SBBIcons.cloud_snowflake_sun_small,
    'name': 'cloud_snowflake_sun_small'
  },
  {
    'icon': SBBIcons.cloud_strong_rain_moon_small,
    'name': 'cloud_strong_rain_moon_small'
  },
  {
    'icon': SBBIcons.cloud_strong_rain_sun_small,
    'name': 'cloud_strong_rain_sun_small'
  },
  {'icon': SBBIcons.cloud_sun_small, 'name': 'cloud_sun_small'},
  {'icon': SBBIcons.cloud_sunshine_small, 'name': 'cloud_sunshine_small'},
  {'icon': SBBIcons.coffee_machine_small, 'name': 'coffee_machine_small'},
  {'icon': SBBIcons.coin_dollar_small, 'name': 'coin_dollar_small'},
  {'icon': SBBIcons.coin_stack_small, 'name': 'coin_stack_small'},
  {'icon': SBBIcons.coins_small, 'name': 'coins_small'},
  {'icon': SBBIcons.combined_mobility_small, 'name': 'combined_mobility_small'},
  {'icon': SBBIcons.construction_small, 'name': 'construction_small'},
  {'icon': SBBIcons.contact_small, 'name': 'contact_small'},
  {'icon': SBBIcons.container_small, 'name': 'container_small'},
  {'icon': SBBIcons.context_menu_small, 'name': 'context_menu_small'},
  {'icon': SBBIcons.controls_small, 'name': 'controls_small'},
  {'icon': SBBIcons.croissant_small, 'name': 'croissant_small'},
  {'icon': SBBIcons.cross_small, 'name': 'cross_small'},
  {'icon': SBBIcons.cup_hot_small, 'name': 'cup_hot_small'},
  {'icon': SBBIcons.curriculum_vitae_small, 'name': 'curriculum_vitae_small'},
  {
    'icon': SBBIcons.customer_assistance_sbb_small,
    'name': 'customer_assistance_sbb_small'
  },
  {'icon': SBBIcons.cutlery_small, 'name': 'cutlery_small'},
  {'icon': SBBIcons.database_small, 'name': 'database_small'},
  {'icon': SBBIcons.desk_adjustable_small, 'name': 'desk_adjustable_small'},
  {'icon': SBBIcons.desk_small, 'name': 'desk_small'},
  {'icon': SBBIcons.diamond_small, 'name': 'diamond_small'},
  {
    'icon': SBBIcons.display_binary_code_small,
    'name': 'display_binary_code_small'
  },
  {'icon': SBBIcons.display_gears_small, 'name': 'display_gears_small'},
  {'icon': SBBIcons.display_small, 'name': 'display_small'},
  {'icon': SBBIcons.document_check_small, 'name': 'document_check_small'},
  {'icon': SBBIcons.document_doc_small, 'name': 'document_doc_small'},
  {'icon': SBBIcons.document_image_small, 'name': 'document_image_small'},
  {'icon': SBBIcons.document_lock_small, 'name': 'document_lock_small'},
  {'icon': SBBIcons.document_pdf_small, 'name': 'document_pdf_small'},
  {'icon': SBBIcons.document_plus_small, 'name': 'document_plus_small'},
  {'icon': SBBIcons.document_ppt_small, 'name': 'document_ppt_small'},
  {'icon': SBBIcons.document_sbb_small, 'name': 'document_sbb_small'},
  {
    'icon': SBBIcons.document_signature_small,
    'name': 'document_signature_small'
  },
  {'icon': SBBIcons.document_sound_small, 'name': 'document_sound_small'},
  {'icon': SBBIcons.document_standard_small, 'name': 'document_standard_small'},
  {'icon': SBBIcons.document_text_small, 'name': 'document_text_small'},
  {'icon': SBBIcons.document_video_small, 'name': 'document_video_small'},
  {'icon': SBBIcons.document_xls_small, 'name': 'document_xls_small'},
  {'icon': SBBIcons.document_zip_small, 'name': 'document_zip_small'},
  {'icon': SBBIcons.dog_small, 'name': 'dog_small'},
  {
    'icon': SBBIcons.double_chevron_small_left_small,
    'name': 'double_chevron_small_left_small'
  },
  {
    'icon': SBBIcons.double_chevron_small_right_small,
    'name': 'double_chevron_small_right_small'
  },
  {'icon': SBBIcons.double_deck_wagon_small, 'name': 'double_deck_wagon_small'},
  {
    'icon': SBBIcons.download_large_data_small,
    'name': 'download_large_data_small'
  },
  {'icon': SBBIcons.download_small, 'name': 'download_small'},
  {
    'icon': SBBIcons.download_small_data_small,
    'name': 'download_small_data_small'
  },
  {'icon': SBBIcons.drag_small, 'name': 'drag_small'},
  {
    'icon': SBBIcons.driverless_bus_profile_small,
    'name': 'driverless_bus_profile_small'
  },
  {'icon': SBBIcons.eiffel_tower_small, 'name': 'eiffel_tower_small'},
  {'icon': SBBIcons.employees_sbb_small, 'name': 'employees_sbb_small'},
  {'icon': SBBIcons.entrance_small, 'name': 'entrance_small'},
  {'icon': SBBIcons.envelope_open_small, 'name': 'envelope_open_small'},
  {'icon': SBBIcons.envelope_small, 'name': 'envelope_small'},
  {'icon': SBBIcons.escalator_small, 'name': 'escalator_small'},
  {'icon': SBBIcons.europe_flag_small, 'name': 'europe_flag_small'},
  {'icon': SBBIcons.exclamation_point_small, 'name': 'exclamation_point_small'},
  {'icon': SBBIcons.exit_small, 'name': 'exit_small'},
  {'icon': SBBIcons.eye_disabled_small, 'name': 'eye_disabled_small'},
  {'icon': SBBIcons.eye_small, 'name': 'eye_small'},
  {'icon': SBBIcons.face_grinning_small, 'name': 'face_grinning_small'},
  {'icon': SBBIcons.face_king_small, 'name': 'face_king_small'},
  {'icon': SBBIcons.face_neutral_small, 'name': 'face_neutral_small'},
  {'icon': SBBIcons.face_sad_small, 'name': 'face_sad_small'},
  {'icon': SBBIcons.face_smiling_small, 'name': 'face_smiling_small'},
  {'icon': SBBIcons.face_worker_small, 'name': 'face_worker_small'},
  {'icon': SBBIcons.factory_small, 'name': 'factory_small'},
  {'icon': SBBIcons.fast_forward_small, 'name': 'fast_forward_small'},
  {'icon': SBBIcons.filter_small, 'name': 'filter_small'},
  {'icon': SBBIcons.filter_x_small, 'name': 'filter_x_small'},
  {'icon': SBBIcons.fingerprint_small, 'name': 'fingerprint_small'},
  {'icon': SBBIcons.fireplace_small, 'name': 'fireplace_small'},
  {
    'icon': SBBIcons.five_circles_interconnected_small,
    'name': 'five_circles_interconnected_small'
  },
  {'icon': SBBIcons.flashlight_off_small, 'name': 'flashlight_off_small'},
  {'icon': SBBIcons.flashlight_on_small, 'name': 'flashlight_on_small'},
  {'icon': SBBIcons.fog_small, 'name': 'fog_small'},
  {'icon': SBBIcons.folder_info_small, 'name': 'folder_info_small'},
  {'icon': SBBIcons.folder_lock_small, 'name': 'folder_lock_small'},
  {'icon': SBBIcons.folder_open_arrow_small, 'name': 'folder_open_arrow_small'},
  {'icon': SBBIcons.folder_open_small, 'name': 'folder_open_small'},
  {'icon': SBBIcons.folder_plus_small, 'name': 'folder_plus_small'},
  {'icon': SBBIcons.folder_small, 'name': 'folder_small'},
  {'icon': SBBIcons.form_small, 'name': 'form_small'},
  {
    'icon': SBBIcons.freight_wagon_container_small,
    'name': 'freight_wagon_container_small'
  },
  {
    'icon': SBBIcons.freight_wagon_globe_small,
    'name': 'freight_wagon_globe_small'
  },
  {'icon': SBBIcons.freight_wagon_small, 'name': 'freight_wagon_small'},
  {
    'icon': SBBIcons.freight_wagon_switzerland_small,
    'name': 'freight_wagon_switzerland_small'
  },
  {'icon': SBBIcons.fullscreen_small, 'name': 'fullscreen_small'},
  {'icon': SBBIcons.funicular_profile_small, 'name': 'funicular_profile_small'},
  {'icon': SBBIcons.gear_changing_small, 'name': 'gear_changing_small'},
  {'icon': SBBIcons.gears_small, 'name': 'gears_small'},
  {'icon': SBBIcons.general_display_small, 'name': 'general_display_small'},
  {'icon': SBBIcons.gift_small, 'name': 'gift_small'},
  {'icon': SBBIcons.glass_cocktail_small, 'name': 'glass_cocktail_small'},
  {'icon': SBBIcons.globe_locomotive_small, 'name': 'globe_locomotive_small'},
  {'icon': SBBIcons.globe_small, 'name': 'globe_small'},
  {'icon': SBBIcons.gondola_profile_small, 'name': 'gondola_profile_small'},
  {'icon': SBBIcons.gps_disabled_small, 'name': 'gps_disabled_small'},
  {'icon': SBBIcons.gps_small, 'name': 'gps_small'},
  {'icon': SBBIcons.gun_small, 'name': 'gun_small'},
  {'icon': SBBIcons.half_fare_card_small, 'name': 'half_fare_card_small'},
  {'icon': SBBIcons.hamburger_menu_small, 'name': 'hamburger_menu_small'},
  {'icon': SBBIcons.hand_briefcase_small, 'name': 'hand_briefcase_small'},
  {'icon': SBBIcons.hand_fingers_snap_small, 'name': 'hand_fingers_snap_small'},
  {'icon': SBBIcons.hand_heart_small, 'name': 'hand_heart_small'},
  {
    'icon': SBBIcons.hand_locomotive_profile_small,
    'name': 'hand_locomotive_profile_small'
  },
  {'icon': SBBIcons.hand_plus_circle_small, 'name': 'hand_plus_circle_small'},
  {'icon': SBBIcons.hand_sbb_small, 'name': 'hand_sbb_small'},
  {'icon': SBBIcons.hand_user_small, 'name': 'hand_user_small'},
  {
    'icon': SBBIcons.hand_with_service_bell_small,
    'name': 'hand_with_service_bell_small'
  },
  {'icon': SBBIcons.handshake_small, 'name': 'handshake_small'},
  {'icon': SBBIcons.heart_small, 'name': 'heart_small'},
  {'icon': SBBIcons.hierarchy_small, 'name': 'hierarchy_small'},
  {'icon': SBBIcons.highlighter_small, 'name': 'highlighter_small'},
  {'icon': SBBIcons.home_power_plug_small, 'name': 'home_power_plug_small'},
  {'icon': SBBIcons.hostel_small, 'name': 'hostel_small'},
  {'icon': SBBIcons.hourglass_small, 'name': 'hourglass_small'},
  {'icon': SBBIcons.house_small, 'name': 'house_small'},
  {'icon': SBBIcons.id_card_employee_small, 'name': 'id_card_employee_small'},
  {'icon': SBBIcons.increase_size_small, 'name': 'increase_size_small'},
  {'icon': SBBIcons.k_r_small, 'name': 'k_r_small'},
  {'icon': SBBIcons.key_small, 'name': 'key_small'},
  {'icon': SBBIcons.keyboard_small, 'name': 'keyboard_small'},
  {'icon': SBBIcons.laptop_small, 'name': 'laptop_small'},
  {'icon': SBBIcons.laptop_smartphone_small, 'name': 'laptop_smartphone_small'},
  {'icon': SBBIcons.layers_small, 'name': 'layers_small'},
  {'icon': SBBIcons.lift_small, 'name': 'lift_small'},
  {'icon': SBBIcons.lighthouse_small, 'name': 'lighthouse_small'},
  {'icon': SBBIcons.link_external_small, 'name': 'link_external_small'},
  {'icon': SBBIcons.link_small, 'name': 'link_small'},
  {'icon': SBBIcons.lips_hand_small, 'name': 'lips_hand_small'},
  {'icon': SBBIcons.list_small, 'name': 'list_small'},
  {'icon': SBBIcons.location_pin_a_small, 'name': 'location_pin_a_small'},
  {'icon': SBBIcons.location_pin_b_small, 'name': 'location_pin_b_small'},
  {
    'icon': SBBIcons.location_pin_camera_small,
    'name': 'location_pin_camera_small'
  },
  {'icon': SBBIcons.location_pin_map_small, 'name': 'location_pin_map_small'},
  {
    'icon': SBBIcons.location_pin_pulse_surrounding_area_small,
    'name': 'location_pin_pulse_surrounding_area_small'
  },
  {'icon': SBBIcons.location_pin_small, 'name': 'location_pin_small'},
  {
    'icon': SBBIcons.location_pin_surrounding_area_power_plug_small,
    'name': 'location_pin_surrounding_area_power_plug_small'
  },
  {
    'icon': SBBIcons.location_pin_surrounding_area_small,
    'name': 'location_pin_surrounding_area_small'
  },
  {'icon': SBBIcons.lock_closed_small, 'name': 'lock_closed_small'},
  {'icon': SBBIcons.lock_open_small, 'name': 'lock_open_small'},
  {'icon': SBBIcons.locker_small, 'name': 'locker_small'},
  {
    'icon': SBBIcons.locomotive_high_speed_small,
    'name': 'locomotive_high_speed_small'
  },
  {
    'icon': SBBIcons.locomotive_profile_moon_small,
    'name': 'locomotive_profile_moon_small'
  },
  {'icon': SBBIcons.locomotive_small, 'name': 'locomotive_small'},
  {
    'icon': SBBIcons.long_distance_coach_profile_small,
    'name': 'long_distance_coach_profile_small'
  },
  {'icon': SBBIcons.lotus_small, 'name': 'lotus_small'},
  {'icon': SBBIcons.low_vision_small, 'name': 'low_vision_small'},
  {
    'icon': SBBIcons.magnifying_glass_minus_small,
    'name': 'magnifying_glass_minus_small'
  },
  {
    'icon': SBBIcons.magnifying_glass_plus_small,
    'name': 'magnifying_glass_plus_small'
  },
  {'icon': SBBIcons.magnifying_glass_small, 'name': 'magnifying_glass_small'},
  {'icon': SBBIcons.medical_facility_small, 'name': 'medical_facility_small'},
  {'icon': SBBIcons.meeting_point_small, 'name': 'meeting_point_small'},
  {'icon': SBBIcons.megaphone_small, 'name': 'megaphone_small'},
  {'icon': SBBIcons.metadata_small, 'name': 'metadata_small'},
  {'icon': SBBIcons.microphone_small, 'name': 'microphone_small'},
  {
    'icon': SBBIcons.microscooter_profile_power_plug_small,
    'name': 'microscooter_profile_power_plug_small'
  },
  {
    'icon': SBBIcons.microscooter_profile_small,
    'name': 'microscooter_profile_small'
  },
  {
    'icon': SBBIcons.milk_brick_disabled_small,
    'name': 'milk_brick_disabled_small'
  },
  {'icon': SBBIcons.minus_small, 'name': 'minus_small'},
  {'icon': SBBIcons.money_exchange_small, 'name': 'money_exchange_small'},
  {'icon': SBBIcons.moon_small, 'name': 'moon_small'},
  {'icon': SBBIcons.mountain_lake_sun_small, 'name': 'mountain_lake_sun_small'},
  {'icon': SBBIcons.mountain_minus_small, 'name': 'mountain_minus_small'},
  {'icon': SBBIcons.mountain_plus_small, 'name': 'mountain_plus_small'},
  {'icon': SBBIcons.mountain_sun_small, 'name': 'mountain_sun_small'},
  {'icon': SBBIcons.moving_bus_small, 'name': 'moving_bus_small'},
  {'icon': SBBIcons.mug_hot_small, 'name': 'mug_hot_small'},
  {'icon': SBBIcons.music_notes_small, 'name': 'music_notes_small'},
  {'icon': SBBIcons.narcotic_small, 'name': 'narcotic_small'},
  {'icon': SBBIcons.network_small, 'name': 'network_small'},
  {'icon': SBBIcons.newspaper_small, 'name': 'newspaper_small'},
  {'icon': SBBIcons.next_small, 'name': 'next_small'},
  {'icon': SBBIcons.nine_squares_small, 'name': 'nine_squares_small'},
  {'icon': SBBIcons.office_chair_small, 'name': 'office_chair_small'},
  {'icon': SBBIcons.onboarding_small, 'name': 'onboarding_small'},
  {'icon': SBBIcons.paper_aeroplane_small, 'name': 'paper_aeroplane_small'},
  {'icon': SBBIcons.paper_clip_small, 'name': 'paper_clip_small'},
  {'icon': SBBIcons.park_and_rail_small, 'name': 'park_and_rail_small'},
  {'icon': SBBIcons.parliament_small, 'name': 'parliament_small'},
  {'icon': SBBIcons.pause_small, 'name': 'pause_small'},
  {'icon': SBBIcons.pen_small, 'name': 'pen_small'},
  {'icon': SBBIcons.percent_small, 'name': 'percent_small'},
  {'icon': SBBIcons.percent_tag_small, 'name': 'percent_tag_small'},
  {'icon': SBBIcons.petrol_station_small, 'name': 'petrol_station_small'},
  {'icon': SBBIcons.picture_small, 'name': 'picture_small'},
  {'icon': SBBIcons.pie_small, 'name': 'pie_small'},
  {'icon': SBBIcons.piggy_bank_small, 'name': 'piggy_bank_small'},
  {'icon': SBBIcons.pin_small, 'name': 'pin_small'},
  {'icon': SBBIcons.pizza_slice_small, 'name': 'pizza_slice_small'},
  {'icon': SBBIcons.platform_display_small, 'name': 'platform_display_small'},
  {'icon': SBBIcons.play_small, 'name': 'play_small'},
  {'icon': SBBIcons.plus_small, 'name': 'plus_small'},
  {'icon': SBBIcons.power_plug_small, 'name': 'power_plug_small'},
  {'icon': SBBIcons.pretzel_small, 'name': 'pretzel_small'},
  {'icon': SBBIcons.previous_small, 'name': 'previous_small'},
  {'icon': SBBIcons.printer_small, 'name': 'printer_small'},
  {'icon': SBBIcons.punctuality_small, 'name': 'punctuality_small'},
  {'icon': SBBIcons.qrcode_disabled_small, 'name': 'qrcode_disabled_small'},
  {'icon': SBBIcons.qrcode_disabled_small_2, 'name': 'qrcode_disabled_small_2'},
  {
    'icon': SBBIcons.qrcode_disabled_two_tickets_small,
    'name': 'qrcode_disabled_two_tickets_small'
  },
  {'icon': SBBIcons.qrcode_small, 'name': 'qrcode_small'},
  {
    'icon': SBBIcons.qrcode_two_tickets_small,
    'name': 'qrcode_two_tickets_small'
  },
  {'icon': SBBIcons.question_answer_small, 'name': 'question_answer_small'},
  {'icon': SBBIcons.question_mark_small, 'name': 'question_mark_small'},
  {
    'icon': SBBIcons.rack_railaway_profile_small,
    'name': 'rack_railaway_profile_small'
  },
  {'icon': SBBIcons.railway_switch_small, 'name': 'railway_switch_small'},
  {'icon': SBBIcons.ramp_user_small, 'name': 'ramp_user_small'},
  {'icon': SBBIcons.record_small, 'name': 'record_small'},
  {'icon': SBBIcons.reduce_size_small, 'name': 'reduce_size_small'},
  {'icon': SBBIcons.rewind_small, 'name': 'rewind_small'},
  {'icon': SBBIcons.robot_small, 'name': 'robot_small'},
  {'icon': SBBIcons.roof_bed_small, 'name': 'roof_bed_small'},
  {'icon': SBBIcons.route_circle_end_small, 'name': 'route_circle_end_small'},
  {
    'icon': SBBIcons.route_circle_start_small,
    'name': 'route_circle_start_small'
  },
  {'icon': SBBIcons.rss_small, 'name': 'rss_small'},
  {'icon': SBBIcons.scanner_small, 'name': 'scanner_small'},
  {
    'icon': SBBIcons.scooter_profile_power_plug_small,
    'name': 'scooter_profile_power_plug_small'
  },
  {'icon': SBBIcons.scooter_profile_small, 'name': 'scooter_profile_small'},
  {
    'icon': SBBIcons.screen_inside_train_small,
    'name': 'screen_inside_train_small'
  },
  {'icon': SBBIcons.seat_small, 'name': 'seat_small'},
  {'icon': SBBIcons.seat_window_small, 'name': 'seat_window_small'},
  {'icon': SBBIcons.service_bell_small, 'name': 'service_bell_small'},
  {'icon': SBBIcons.share_small, 'name': 'share_small'},
  {
    'icon': SBBIcons.ship_steering_wheel_small,
    'name': 'ship_steering_wheel_small'
  },
  {'icon': SBBIcons.shirt_shoe_small, 'name': 'shirt_shoe_small'},
  {
    'icon': SBBIcons.shopping_bag_coupon_small,
    'name': 'shopping_bag_coupon_small'
  },
  {'icon': SBBIcons.shopping_bag_fast_small, 'name': 'shopping_bag_fast_small'},
  {'icon': SBBIcons.shopping_bag_small, 'name': 'shopping_bag_small'},
  {'icon': SBBIcons.shopping_cart_small, 'name': 'shopping_cart_small'},
  {'icon': SBBIcons.shuttle_small, 'name': 'shuttle_small'},
  {
    'icon': SBBIcons.sign_exclamation_point_small,
    'name': 'sign_exclamation_point_small'
  },
  {'icon': SBBIcons.sign_parking_small, 'name': 'sign_parking_small'},
  {'icon': SBBIcons.sign_x_small, 'name': 'sign_x_small'},
  {'icon': SBBIcons.skis_ski_poles_small, 'name': 'skis_ski_poles_small'},
  {
    'icon': SBBIcons.smartphone_shaking_small,
    'name': 'smartphone_shaking_small'
  },
  {'icon': SBBIcons.smartphone_small, 'name': 'smartphone_small'},
  {'icon': SBBIcons.spanner_small, 'name': 'spanner_small'},
  {'icon': SBBIcons.speaker_small, 'name': 'speaker_small'},
  {
    'icon': SBBIcons.speech_bubble_group_empty_small,
    'name': 'speech_bubble_group_empty_small'
  },
  {'icon': SBBIcons.speech_bubble_small, 'name': 'speech_bubble_small'},
  {'icon': SBBIcons.stairs_user_small, 'name': 'stairs_user_small'},
  {'icon': SBBIcons.star_small, 'name': 'star_small'},
  {'icon': SBBIcons.station_small, 'name': 'station_small'},
  {
    'icon': SBBIcons.station_surrounding_area_small,
    'name': 'station_surrounding_area_small'
  },
  {'icon': SBBIcons.stop_small, 'name': 'stop_small'},
  {
    'icon': SBBIcons.street_location_pin_small,
    'name': 'street_location_pin_small'
  },
  {'icon': SBBIcons.suitcase_disabled_small, 'name': 'suitcase_disabled_small'},
  {'icon': SBBIcons.suitcase_small, 'name': 'suitcase_small'},
  {'icon': SBBIcons.sun_moon_small, 'name': 'sun_moon_small'},
  {'icon': SBBIcons.sunrise_small, 'name': 'sunrise_small'},
  {'icon': SBBIcons.sunshade_sun_sand_small, 'name': 'sunshade_sun_sand_small'},
  {'icon': SBBIcons.sunshine_small, 'name': 'sunshine_small'},
  {'icon': SBBIcons.swisspass_small, 'name': 'swisspass_small'},
  {
    'icon': SBBIcons.swisspass_temporary_small,
    'name': 'swisspass_temporary_small'
  },
  {'icon': SBBIcons.switzerland_route_small, 'name': 'switzerland_route_small'},
  {'icon': SBBIcons.switzerland_small, 'name': 'switzerland_small'},
  {'icon': SBBIcons.tablet_small, 'name': 'tablet_small'},
  {'icon': SBBIcons.tablet_smartphone_small, 'name': 'tablet_smartphone_small'},
  {'icon': SBBIcons.tag_small, 'name': 'tag_small'},
  {'icon': SBBIcons.target_small, 'name': 'target_small'},
  {'icon': SBBIcons.taxi_profile_small, 'name': 'taxi_profile_small'},
  {'icon': SBBIcons.taxi_small, 'name': 'taxi_small'},
  {'icon': SBBIcons.telephone_gsm_small, 'name': 'telephone_gsm_small'},
  {
    'icon': SBBIcons.telephone_receiver_small,
    'name': 'telephone_receiver_small'
  },
  {'icon': SBBIcons.three_gears_small, 'name': 'three_gears_small'},
  {'icon': SBBIcons.thumb_down_small, 'name': 'thumb_down_small'},
  {'icon': SBBIcons.thumb_up_small, 'name': 'thumb_up_small'},
  {'icon': SBBIcons.tick_small, 'name': 'tick_small'},
  {'icon': SBBIcons.ticket_day_small, 'name': 'ticket_day_small'},
  {'icon': SBBIcons.ticket_disabled_small, 'name': 'ticket_disabled_small'},
  {'icon': SBBIcons.ticket_fv_small, 'name': 'ticket_fv_small'},
  {'icon': SBBIcons.ticket_heart_small, 'name': 'ticket_heart_small'},
  {'icon': SBBIcons.ticket_ipv_small, 'name': 'ticket_ipv_small'},
  {'icon': SBBIcons.ticket_journey_small, 'name': 'ticket_journey_small'},
  {'icon': SBBIcons.ticket_machine_small, 'name': 'ticket_machine_small'},
  {
    'icon': SBBIcons.ticket_machine_ticket_small,
    'name': 'ticket_machine_ticket_small'
  },
  {'icon': SBBIcons.ticket_moon_star_small, 'name': 'ticket_moon_star_small'},
  {'icon': SBBIcons.ticket_parking_small, 'name': 'ticket_parking_small'},
  {'icon': SBBIcons.ticket_percent_small, 'name': 'ticket_percent_small'},
  {'icon': SBBIcons.ticket_route_small, 'name': 'ticket_route_small'},
  {'icon': SBBIcons.ticket_rv_small, 'name': 'ticket_rv_small'},
  {'icon': SBBIcons.ticket_star_small, 'name': 'ticket_star_small'},
  {'icon': SBBIcons.tickets_class_small, 'name': 'tickets_class_small'},
  {'icon': SBBIcons.timetable_small, 'name': 'timetable_small'},
  {'icon': SBBIcons.toilet_small, 'name': 'toilet_small'},
  {'icon': SBBIcons.torch_small, 'name': 'torch_small'},
  {'icon': SBBIcons.train_profile_small, 'name': 'train_profile_small'},
  {'icon': SBBIcons.train_signal_small, 'name': 'train_signal_small'},
  {'icon': SBBIcons.train_small, 'name': 'train_small'},
  {'icon': SBBIcons.train_station_small, 'name': 'train_station_small'},
  {
    'icon': SBBIcons.train_tracks_horizontal_small,
    'name': 'train_tracks_horizontal_small'
  },
  {'icon': SBBIcons.train_tracks_small, 'name': 'train_tracks_small'},
  {'icon': SBBIcons.tram_profile_small, 'name': 'tram_profile_small'},
  {'icon': SBBIcons.tram_small, 'name': 'tram_small'},
  {'icon': SBBIcons.translate_small, 'name': 'translate_small'},
  {'icon': SBBIcons.trash_small, 'name': 'trash_small'},
  {'icon': SBBIcons.travel_backpack_small, 'name': 'travel_backpack_small'},
  {'icon': SBBIcons.tree_small, 'name': 'tree_small'},
  {'icon': SBBIcons.two_adults_kid_small, 'name': 'two_adults_kid_small'},
  {'icon': SBBIcons.two_finger_tap_small, 'name': 'two_finger_tap_small'},
  {'icon': SBBIcons.two_folders_small, 'name': 'two_folders_small'},
  {
    'icon': SBBIcons.two_speech_bubbles_small,
    'name': 'two_speech_bubbles_small'
  },
  {'icon': SBBIcons.two_users_small, 'name': 'two_users_small'},
  {
    'icon': SBBIcons.underground_vehicule_profile_small,
    'name': 'underground_vehicule_profile_small'
  },
  {'icon': SBBIcons.upload_small, 'name': 'upload_small'},
  {'icon': SBBIcons.user_change_small, 'name': 'user_change_small'},
  {
    'icon': SBBIcons.user_group_round_table_small,
    'name': 'user_group_round_table_small'
  },
  {'icon': SBBIcons.user_group_row_small, 'name': 'user_group_row_small'},
  {'icon': SBBIcons.user_group_small, 'name': 'user_group_small'},
  {'icon': SBBIcons.user_hat_small, 'name': 'user_hat_small'},
  {
    'icon': SBBIcons.user_headset_display_small,
    'name': 'user_headset_display_small'
  },
  {'icon': SBBIcons.user_headset_small, 'name': 'user_headset_small'},
  {'icon': SBBIcons.user_key_small, 'name': 'user_key_small'},
  {'icon': SBBIcons.user_plus_small, 'name': 'user_plus_small'},
  {'icon': SBBIcons.user_small, 'name': 'user_small'},
  {'icon': SBBIcons.user_tie_small, 'name': 'user_tie_small'},
  {'icon': SBBIcons.vegan_small, 'name': 'vegan_small'},
  {'icon': SBBIcons.vegetarian_small, 'name': 'vegetarian_small'},
  {'icon': SBBIcons.wagon_small, 'name': 'wagon_small'},
  {'icon': SBBIcons.waiting_room_small, 'name': 'waiting_room_small'},
  {'icon': SBBIcons.walk_fast_small, 'name': 'walk_fast_small'},
  {'icon': SBBIcons.walk_large_small, 'name': 'walk_large_small'},
  {'icon': SBBIcons.walk_slow_small, 'name': 'walk_slow_small'},
  {'icon': SBBIcons.walk_small, 'name': 'walk_small'},
  {'icon': SBBIcons.walkie_talkie_small, 'name': 'walkie_talkie_small'},
  {'icon': SBBIcons.wallet_small, 'name': 'wallet_small'},
  {'icon': SBBIcons.warning_light_small, 'name': 'warning_light_small'},
  {'icon': SBBIcons.washing_machine_small, 'name': 'washing_machine_small'},
  {'icon': SBBIcons.waves_ladder_small, 'name': 'waves_ladder_small'},
  {'icon': SBBIcons.weather_unknown_small, 'name': 'weather_unknown_small'},
  {'icon': SBBIcons.weight_small, 'name': 'weight_small'},
  {
    'icon': SBBIcons.wheelchair_inaccessible_small,
    'name': 'wheelchair_inaccessible_small'
  },
  {
    'icon': SBBIcons.wheelchair_partially_small,
    'name': 'wheelchair_partially_small'
  },
  {
    'icon': SBBIcons.wheelchair_reservation_small,
    'name': 'wheelchair_reservation_small'
  },
  {'icon': SBBIcons.wheelchair_small, 'name': 'wheelchair_small'},
  {
    'icon': SBBIcons.wheelchair_uncertain_small,
    'name': 'wheelchair_uncertain_small'
  },
  {'icon': SBBIcons.wifi_disabled_small, 'name': 'wifi_disabled_small'},
  {'icon': SBBIcons.wifi_small, 'name': 'wifi_small'},
  {'icon': SBBIcons.wine_cheese_small, 'name': 'wine_cheese_small'},
];

const iconsMedium = [
  {
    'icon': SBBIcons.adouble_chevron_small_right_medium,
    'name': 'adouble_chevron_small_right_medium'
  },
  {'icon': SBBIcons.aerosol_can_medium, 'name': 'aerosol_can_medium'},
  {'icon': SBBIcons.airplane_medium, 'name': 'airplane_medium'},
  {'icon': SBBIcons.alarm_clock_medium, 'name': 'alarm_clock_medium'},
  {'icon': SBBIcons.app_icon_medium, 'name': 'app_icon_medium'},
  {'icon': SBBIcons.apple_bag_medium, 'name': 'apple_bag_medium'},
  {'icon': SBBIcons.archive_box_medium, 'name': 'archive_box_medium'},
  {'icon': SBBIcons.armchair_medium, 'name': 'armchair_medium'},
  {
    'icon': SBBIcons.armchair_profile_user_medium,
    'name': 'armchair_profile_user_medium'
  },
  {
    'icon': SBBIcons.arrow_change_horizontal_medium,
    'name': 'arrow_change_horizontal_medium'
  },
  {'icon': SBBIcons.arrow_change_medium, 'name': 'arrow_change_medium'},
  {'icon': SBBIcons.arrow_circle_eye_medium, 'name': 'arrow_circle_eye_medium'},
  {
    'icon': SBBIcons.arrow_circle_lightning_medium,
    'name': 'arrow_circle_lightning_medium'
  },
  {'icon': SBBIcons.arrow_circle_medium, 'name': 'arrow_circle_medium'},
  {
    'icon': SBBIcons.arrow_circle_switzerland_medium,
    'name': 'arrow_circle_switzerland_medium'
  },
  {
    'icon': SBBIcons.arrow_circle_train_tracks_medium,
    'name': 'arrow_circle_train_tracks_medium'
  },
  {
    'icon': SBBIcons.arrow_circle_two_users_medium,
    'name': 'arrow_circle_two_users_medium'
  },
  {'icon': SBBIcons.arrow_compass_medium, 'name': 'arrow_compass_medium'},
  {'icon': SBBIcons.arrow_down_medium, 'name': 'arrow_down_medium'},
  {'icon': SBBIcons.arrow_long_left_medium, 'name': 'arrow_long_left_medium'},
  {'icon': SBBIcons.arrow_long_right_medium, 'name': 'arrow_long_right_medium'},
  {'icon': SBBIcons.arrow_right_medium, 'name': 'arrow_right_medium'},
  {'icon': SBBIcons.arrows_circle_medium, 'name': 'arrows_circle_medium'},
  {
    'icon': SBBIcons.arrows_left_right_down_up_medium,
    'name': 'arrows_left_right_down_up_medium'
  },
  {
    'icon': SBBIcons.arrows_left_right_medium,
    'name': 'arrows_left_right_medium'
  },
  {
    'icon': SBBIcons.arrows_right_left_medium,
    'name': 'arrows_right_left_medium'
  },
  {'icon': SBBIcons.arrows_up_down_medium, 'name': 'arrows_up_down_medium'},
  {'icon': SBBIcons.avatar_police_medium, 'name': 'avatar_police_medium'},
  {
    'icon': SBBIcons.avatar_train_staff_disabled_medium,
    'name': 'avatar_train_staff_disabled_medium'
  },
  {
    'icon': SBBIcons.avatar_train_staff_medium,
    'name': 'avatar_train_staff_medium'
  },
  {'icon': SBBIcons.backpack_medium, 'name': 'backpack_medium'},
  {'icon': SBBIcons.banknotes_dollar_medium, 'name': 'banknotes_dollar_medium'},
  {
    'icon': SBBIcons.barrier_construction_medium,
    'name': 'barrier_construction_medium'
  },
  {
    'icon': SBBIcons.battery_level_empty_medium,
    'name': 'battery_level_empty_medium'
  },
  {
    'icon': SBBIcons.battery_level_high_medium,
    'name': 'battery_level_high_medium'
  },
  {
    'icon': SBBIcons.battery_level_low_medium,
    'name': 'battery_level_low_medium'
  },
  {
    'icon': SBBIcons.battery_level_medium_medium,
    'name': 'battery_level_medium_medium'
  },
  {'icon': SBBIcons.bell_disabled_medium, 'name': 'bell_disabled_medium'},
  {'icon': SBBIcons.bell_medium, 'name': 'bell_medium'},
  {'icon': SBBIcons.bicycle_medium, 'name': 'bicycle_medium'},
  {
    'icon': SBBIcons.bicycle_profile_user_group_circle_medium,
    'name': 'bicycle_profile_user_group_circle_medium'
  },
  {
    'icon': SBBIcons.bike_profile_power_plug_medium,
    'name': 'bike_profile_power_plug_medium'
  },
  {
    'icon': SBBIcons.bike_profile_sign_parking_medium,
    'name': 'bike_profile_sign_parking_medium'
  },
  {'icon': SBBIcons.binoculars_medium, 'name': 'binoculars_medium'},
  {
    'icon': SBBIcons.bluetooth_disabled_medium,
    'name': 'bluetooth_disabled_medium'
  },
  {'icon': SBBIcons.bluetooth_medium, 'name': 'bluetooth_medium'},
  {'icon': SBBIcons.boat_profile_medium, 'name': 'boat_profile_medium'},
  {'icon': SBBIcons.book_medium, 'name': 'book_medium'},
  {
    'icon': SBBIcons.book_section_mark_medium,
    'name': 'book_section_mark_medium'
  },
  {'icon': SBBIcons.bottle_apple_medium, 'name': 'bottle_apple_medium'},
  {'icon': SBBIcons.briefcase_medium, 'name': 'briefcase_medium'},
  {'icon': SBBIcons.brochure_medium, 'name': 'brochure_medium'},
  {'icon': SBBIcons.browser_medium, 'name': 'browser_medium'},
  {
    'icon': SBBIcons.bucket_foam_broom_medium,
    'name': 'bucket_foam_broom_medium'
  },
  {'icon': SBBIcons.building_tree_medium, 'name': 'building_tree_medium'},
  {'icon': SBBIcons.bulb_off_medium, 'name': 'bulb_off_medium'},
  {'icon': SBBIcons.bulb_on_medium, 'name': 'bulb_on_medium'},
  {'icon': SBBIcons.bus_medium, 'name': 'bus_medium'},
  {'icon': SBBIcons.bus_profile_medium, 'name': 'bus_profile_medium'},
  {'icon': SBBIcons.bus_sbb_medium, 'name': 'bus_sbb_medium'},
  {'icon': SBBIcons.bus_stop_medium, 'name': 'bus_stop_medium'},
  {
    'icon': SBBIcons.bus_surrounding_area_medium,
    'name': 'bus_surrounding_area_medium'
  },
  {'icon': SBBIcons.button_power_medium, 'name': 'button_power_medium'},
  {
    'icon': SBBIcons.cable_car_profile_medium,
    'name': 'cable_car_profile_medium'
  },
  {'icon': SBBIcons.calculator_medium, 'name': 'calculator_medium'},
  {'icon': SBBIcons.calendar_medium, 'name': 'calendar_medium'},
  {'icon': SBBIcons.calendar_one_day_medium, 'name': 'calendar_one_day_medium'},
  {'icon': SBBIcons.camera_medium, 'name': 'camera_medium'},
  {'icon': SBBIcons.car_medium, 'name': 'car_medium'},
  {'icon': SBBIcons.car_profile_medium, 'name': 'car_profile_medium'},
  {
    'icon': SBBIcons.car_profile_power_plug_medium,
    'name': 'car_profile_power_plug_medium'
  },
  {
    'icon': SBBIcons.car_profile_sign_parking_medium,
    'name': 'car_profile_sign_parking_medium'
  },
  {
    'icon': SBBIcons.car_profile_user_group_circle_medium,
    'name': 'car_profile_user_group_circle_medium'
  },
  {'icon': SBBIcons.car_sign_parking_medium, 'name': 'car_sign_parking_medium'},
  {'icon': SBBIcons.cash_register_medium, 'name': 'cash_register_medium'},
  {
    'icon': SBBIcons.certificate_ribbon_medium,
    'name': 'certificate_ribbon_medium'
  },
  {
    'icon': SBBIcons.certificate_ribbon_tick_medium,
    'name': 'certificate_ribbon_tick_medium'
  },
  {
    'icon': SBBIcons.chairlift_profile_medium,
    'name': 'chairlift_profile_medium'
  },
  {'icon': SBBIcons.charging_station_medium, 'name': 'charging_station_medium'},
  {'icon': SBBIcons.chart_column_medium, 'name': 'chart_column_medium'},
  {
    'icon': SBBIcons.chart_column_trend_medium,
    'name': 'chart_column_trend_medium'
  },
  {'icon': SBBIcons.chart_line_medium, 'name': 'chart_line_medium'},
  {'icon': SBBIcons.chart_pie_medium, 'name': 'chart_pie_medium'},
  {'icon': SBBIcons.chevron_left_medium, 'name': 'chevron_left_medium'},
  {'icon': SBBIcons.chevron_right_medium, 'name': 'chevron_right_medium'},
  {
    'icon': SBBIcons.chevron_small_down_circle_medium,
    'name': 'chevron_small_down_circle_medium'
  },
  {
    'icon': SBBIcons.chevron_small_down_medium,
    'name': 'chevron_small_down_medium'
  },
  {
    'icon': SBBIcons.chevron_small_left_circle_medium,
    'name': 'chevron_small_left_circle_medium'
  },
  {
    'icon': SBBIcons.chevron_small_left_medium,
    'name': 'chevron_small_left_medium'
  },
  {
    'icon': SBBIcons.chevron_small_right_circle_medium,
    'name': 'chevron_small_right_circle_medium'
  },
  {
    'icon': SBBIcons.chevron_small_right_medium,
    'name': 'chevron_small_right_medium'
  },
  {
    'icon': SBBIcons.chevron_small_up_circle_medium,
    'name': 'chevron_small_up_circle_medium'
  },
  {'icon': SBBIcons.chevron_small_up_medium, 'name': 'chevron_small_up_medium'},
  {'icon': SBBIcons.child_adult_medium, 'name': 'child_adult_medium'},
  {
    'icon': SBBIcons.cigarette_disabled_medium,
    'name': 'cigarette_disabled_medium'
  },
  {'icon': SBBIcons.cigarette_medium, 'name': 'cigarette_medium'},
  {'icon': SBBIcons.circle_cross_medium, 'name': 'circle_cross_medium'},
  {
    'icon': SBBIcons.circle_information_medium,
    'name': 'circle_information_medium'
  },
  {
    'icon': SBBIcons.circle_information_small_medium,
    'name': 'circle_information_small_medium'
  },
  {'icon': SBBIcons.circle_minus_medium, 'name': 'circle_minus_medium'},
  {'icon': SBBIcons.circle_play_medium, 'name': 'circle_play_medium'},
  {'icon': SBBIcons.circle_plus_medium, 'name': 'circle_plus_medium'},
  {
    'icon': SBBIcons.circle_question_mark_medium,
    'name': 'circle_question_mark_medium'
  },
  {'icon': SBBIcons.circle_tick_medium, 'name': 'circle_tick_medium'},
  {
    'icon': SBBIcons.circle_triangle_square_medium,
    'name': 'circle_triangle_square_medium'
  },
  {'icon': SBBIcons.city_medium, 'name': 'city_medium'},
  {'icon': SBBIcons.clapperboard_medium, 'name': 'clapperboard_medium'},
  {'icon': SBBIcons.clipboard_cross_medium, 'name': 'clipboard_cross_medium'},
  {
    'icon': SBBIcons.clipboard_question_mark_medium,
    'name': 'clipboard_question_mark_medium'
  },
  {'icon': SBBIcons.clipboard_tick_medium, 'name': 'clipboard_tick_medium'},
  {'icon': SBBIcons.clock_medium, 'name': 'clock_medium'},
  {'icon': SBBIcons.cloud_dense_fog_medium, 'name': 'cloud_dense_fog_medium'},
  {'icon': SBBIcons.cloud_drops_medium, 'name': 'cloud_drops_medium'},
  {'icon': SBBIcons.cloud_drops_moon_medium, 'name': 'cloud_drops_moon_medium'},
  {'icon': SBBIcons.cloud_fog_medium, 'name': 'cloud_fog_medium'},
  {'icon': SBBIcons.cloud_ice_medium, 'name': 'cloud_ice_medium'},
  {'icon': SBBIcons.cloud_lightning_medium, 'name': 'cloud_lightning_medium'},
  {
    'icon': SBBIcons.cloud_lightning_moon_medium,
    'name': 'cloud_lightning_moon_medium'
  },
  {
    'icon': SBBIcons.cloud_little_snow_moon_medium,
    'name': 'cloud_little_snow_moon_medium'
  },
  {
    'icon': SBBIcons.cloud_little_snow_sun_medium,
    'name': 'cloud_little_snow_sun_medium'
  },
  {'icon': SBBIcons.cloud_medium, 'name': 'cloud_medium'},
  {'icon': SBBIcons.cloud_moon_medium, 'name': 'cloud_moon_medium'},
  {'icon': SBBIcons.cloud_rain_medium, 'name': 'cloud_rain_medium'},
  {'icon': SBBIcons.cloud_rain_snow_medium, 'name': 'cloud_rain_snow_medium'},
  {
    'icon': SBBIcons.cloud_rain_snow_moon_medium,
    'name': 'cloud_rain_snow_moon_medium'
  },
  {
    'icon': SBBIcons.cloud_rain_snow_sun_medium,
    'name': 'cloud_rain_snow_sun_medium'
  },
  {'icon': SBBIcons.cloud_rain_sun_medium, 'name': 'cloud_rain_sun_medium'},
  {
    'icon': SBBIcons.cloud_snow_lightning_medium,
    'name': 'cloud_snow_lightning_medium'
  },
  {'icon': SBBIcons.cloud_snow_medium, 'name': 'cloud_snow_medium'},
  {'icon': SBBIcons.cloud_snow_moon_medium, 'name': 'cloud_snow_moon_medium'},
  {'icon': SBBIcons.cloud_snow_sun_medium, 'name': 'cloud_snow_sun_medium'},
  {'icon': SBBIcons.cloud_snowflake_medium, 'name': 'cloud_snowflake_medium'},
  {
    'icon': SBBIcons.cloud_snowflake_sun_medium,
    'name': 'cloud_snowflake_sun_medium'
  },
  {
    'icon': SBBIcons.cloud_strong_rain_moon_medium,
    'name': 'cloud_strong_rain_moon_medium'
  },
  {
    'icon': SBBIcons.cloud_strong_rain_sun_medium,
    'name': 'cloud_strong_rain_sun_medium'
  },
  {'icon': SBBIcons.cloud_sun_medium, 'name': 'cloud_sun_medium'},
  {'icon': SBBIcons.cloud_sunshine_medium, 'name': 'cloud_sunshine_medium'},
  {'icon': SBBIcons.coffee_machine_medium, 'name': 'coffee_machine_medium'},
  {'icon': SBBIcons.coin_dollar_medium, 'name': 'coin_dollar_medium'},
  {'icon': SBBIcons.coin_stack_medium, 'name': 'coin_stack_medium'},
  {'icon': SBBIcons.coins_medium, 'name': 'coins_medium'},
  {
    'icon': SBBIcons.combined_mobility_medium,
    'name': 'combined_mobility_medium'
  },
  {'icon': SBBIcons.construction_medium, 'name': 'construction_medium'},
  {'icon': SBBIcons.contact_medium, 'name': 'contact_medium'},
  {'icon': SBBIcons.container_medium, 'name': 'container_medium'},
  {'icon': SBBIcons.context_menu_medium, 'name': 'context_menu_medium'},
  {'icon': SBBIcons.controls_medium, 'name': 'controls_medium'},
  {'icon': SBBIcons.croissant_medium, 'name': 'croissant_medium'},
  {'icon': SBBIcons.cross_medium, 'name': 'cross_medium'},
  {'icon': SBBIcons.cup_hot_medium, 'name': 'cup_hot_medium'},
  {'icon': SBBIcons.curriculum_vitae_medium, 'name': 'curriculum_vitae_medium'},
  {
    'icon': SBBIcons.customer_assistance_sbb_medium,
    'name': 'customer_assistance_sbb_medium'
  },
  {'icon': SBBIcons.cutlery_medium, 'name': 'cutlery_medium'},
  {'icon': SBBIcons.database_medium, 'name': 'database_medium'},
  {'icon': SBBIcons.desk_adjustable_medium, 'name': 'desk_adjustable_medium'},
  {'icon': SBBIcons.desk_medium, 'name': 'desk_medium'},
  {'icon': SBBIcons.diamond_medium, 'name': 'diamond_medium'},
  {
    'icon': SBBIcons.display_binary_code_medium,
    'name': 'display_binary_code_medium'
  },
  {'icon': SBBIcons.display_gears_medium, 'name': 'display_gears_medium'},
  {'icon': SBBIcons.display_medium, 'name': 'display_medium'},
  {'icon': SBBIcons.document_check_medium, 'name': 'document_check_medium'},
  {'icon': SBBIcons.document_doc_medium, 'name': 'document_doc_medium'},
  {'icon': SBBIcons.document_image_medium, 'name': 'document_image_medium'},
  {'icon': SBBIcons.document_lock_medium, 'name': 'document_lock_medium'},
  {'icon': SBBIcons.document_pdf_medium, 'name': 'document_pdf_medium'},
  {'icon': SBBIcons.document_plus_medium, 'name': 'document_plus_medium'},
  {'icon': SBBIcons.document_ppt_medium, 'name': 'document_ppt_medium'},
  {'icon': SBBIcons.document_sbb_medium, 'name': 'document_sbb_medium'},
  {
    'icon': SBBIcons.document_signature_medium,
    'name': 'document_signature_medium'
  },
  {'icon': SBBIcons.document_sound_medium, 'name': 'document_sound_medium'},
  {
    'icon': SBBIcons.document_standard_medium,
    'name': 'document_standard_medium'
  },
  {'icon': SBBIcons.document_text_medium, 'name': 'document_text_medium'},
  {'icon': SBBIcons.document_video_medium, 'name': 'document_video_medium'},
  {'icon': SBBIcons.document_xls_medium, 'name': 'document_xls_medium'},
  {'icon': SBBIcons.document_zip_medium, 'name': 'document_zip_medium'},
  {'icon': SBBIcons.dog_medium, 'name': 'dog_medium'},
  {
    'icon': SBBIcons.double_chevron_small_left_medium,
    'name': 'double_chevron_small_left_medium'
  },
  {
    'icon': SBBIcons.double_deck_wagon_medium,
    'name': 'double_deck_wagon_medium'
  },
  {
    'icon': SBBIcons.download_large_data_medium,
    'name': 'download_large_data_medium'
  },
  {'icon': SBBIcons.download_medium, 'name': 'download_medium'},
  {
    'icon': SBBIcons.download_small_data_medium,
    'name': 'download_small_data_medium'
  },
  {'icon': SBBIcons.drag_medium, 'name': 'drag_medium'},
  {
    'icon': SBBIcons.driverless_bus_profile_medium,
    'name': 'driverless_bus_profile_medium'
  },
  {'icon': SBBIcons.eiffel_tower_medium, 'name': 'eiffel_tower_medium'},
  {'icon': SBBIcons.employees_sbb_medium, 'name': 'employees_sbb_medium'},
  {'icon': SBBIcons.entrance_medium, 'name': 'entrance_medium'},
  {'icon': SBBIcons.envelope_medium, 'name': 'envelope_medium'},
  {'icon': SBBIcons.envelope_open_medium, 'name': 'envelope_open_medium'},
  {'icon': SBBIcons.escalator_medium, 'name': 'escalator_medium'},
  {'icon': SBBIcons.europe_flag_medium, 'name': 'europe_flag_medium'},
  {
    'icon': SBBIcons.exclamation_point_medium,
    'name': 'exclamation_point_medium'
  },
  {'icon': SBBIcons.exit_medium, 'name': 'exit_medium'},
  {'icon': SBBIcons.eye_disabled_medium, 'name': 'eye_disabled_medium'},
  {'icon': SBBIcons.eye_medium, 'name': 'eye_medium'},
  {'icon': SBBIcons.face_grinning_medium, 'name': 'face_grinning_medium'},
  {'icon': SBBIcons.face_king_medium, 'name': 'face_king_medium'},
  {'icon': SBBIcons.face_neutral_medium, 'name': 'face_neutral_medium'},
  {'icon': SBBIcons.face_sad_medium, 'name': 'face_sad_medium'},
  {'icon': SBBIcons.face_smiling_medium, 'name': 'face_smiling_medium'},
  {'icon': SBBIcons.face_worker_medium, 'name': 'face_worker_medium'},
  {'icon': SBBIcons.factory_medium, 'name': 'factory_medium'},
  {'icon': SBBIcons.fast_forward_medium, 'name': 'fast_forward_medium'},
  {'icon': SBBIcons.filter_medium, 'name': 'filter_medium'},
  {'icon': SBBIcons.filter_x_medium, 'name': 'filter_x_medium'},
  {'icon': SBBIcons.fingerprint_medium, 'name': 'fingerprint_medium'},
  {'icon': SBBIcons.fireplace_medium, 'name': 'fireplace_medium'},
  {
    'icon': SBBIcons.five_circles_interconnected_medium,
    'name': 'five_circles_interconnected_medium'
  },
  {'icon': SBBIcons.flashlight_off_medium, 'name': 'flashlight_off_medium'},
  {'icon': SBBIcons.flashlight_on_medium, 'name': 'flashlight_on_medium'},
  {'icon': SBBIcons.fog_medium, 'name': 'fog_medium'},
  {'icon': SBBIcons.folder_info_medium, 'name': 'folder_info_medium'},
  {'icon': SBBIcons.folder_lock_medium, 'name': 'folder_lock_medium'},
  {'icon': SBBIcons.folder_medium, 'name': 'folder_medium'},
  {
    'icon': SBBIcons.folder_open_arrow_medium,
    'name': 'folder_open_arrow_medium'
  },
  {'icon': SBBIcons.folder_open_medium, 'name': 'folder_open_medium'},
  {'icon': SBBIcons.folder_plus_medium, 'name': 'folder_plus_medium'},
  {'icon': SBBIcons.form_medium, 'name': 'form_medium'},
  {
    'icon': SBBIcons.freight_wagon_container_medium,
    'name': 'freight_wagon_container_medium'
  },
  {
    'icon': SBBIcons.freight_wagon_globe_medium,
    'name': 'freight_wagon_globe_medium'
  },
  {'icon': SBBIcons.freight_wagon_medium, 'name': 'freight_wagon_medium'},
  {
    'icon': SBBIcons.freight_wagon_switzerland_medium,
    'name': 'freight_wagon_switzerland_medium'
  },
  {'icon': SBBIcons.fullscreen_medium, 'name': 'fullscreen_medium'},
  {
    'icon': SBBIcons.funicular_profile_medium,
    'name': 'funicular_profile_medium'
  },
  {'icon': SBBIcons.gear_changing_medium, 'name': 'gear_changing_medium'},
  {'icon': SBBIcons.gears_medium, 'name': 'gears_medium'},
  {'icon': SBBIcons.general_display_medium, 'name': 'general_display_medium'},
  {'icon': SBBIcons.gift_medium, 'name': 'gift_medium'},
  {'icon': SBBIcons.glass_cocktail_medium, 'name': 'glass_cocktail_medium'},
  {'icon': SBBIcons.globe_locomotive_medium, 'name': 'globe_locomotive_medium'},
  {'icon': SBBIcons.globe_medium, 'name': 'globe_medium'},
  {'icon': SBBIcons.gondola_profile_medium, 'name': 'gondola_profile_medium'},
  {'icon': SBBIcons.gps_disabled_medium, 'name': 'gps_disabled_medium'},
  {'icon': SBBIcons.gps_medium, 'name': 'gps_medium'},
  {'icon': SBBIcons.gun_medium, 'name': 'gun_medium'},
  {'icon': SBBIcons.half_fare_card_medium, 'name': 'half_fare_card_medium'},
  {'icon': SBBIcons.hamburger_menu_medium, 'name': 'hamburger_menu_medium'},
  {'icon': SBBIcons.hand_briefcase_medium, 'name': 'hand_briefcase_medium'},
  {
    'icon': SBBIcons.hand_fingers_snap_medium,
    'name': 'hand_fingers_snap_medium'
  },
  {'icon': SBBIcons.hand_heart_medium, 'name': 'hand_heart_medium'},
  {
    'icon': SBBIcons.hand_locomotive_profile_medium,
    'name': 'hand_locomotive_profile_medium'
  },
  {'icon': SBBIcons.hand_plus_circle_medium, 'name': 'hand_plus_circle_medium'},
  {'icon': SBBIcons.hand_sbb_medium, 'name': 'hand_sbb_medium'},
  {'icon': SBBIcons.hand_user_medium, 'name': 'hand_user_medium'},
  {
    'icon': SBBIcons.hand_with_service_bell_medium,
    'name': 'hand_with_service_bell_medium'
  },
  {'icon': SBBIcons.handshake_medium, 'name': 'handshake_medium'},
  {'icon': SBBIcons.heart_medium, 'name': 'heart_medium'},
  {'icon': SBBIcons.hierarchy_medium, 'name': 'hierarchy_medium'},
  {'icon': SBBIcons.highlighter_medium, 'name': 'highlighter_medium'},
  {'icon': SBBIcons.home_power_plug_medium, 'name': 'home_power_plug_medium'},
  {'icon': SBBIcons.hostel_medium, 'name': 'hostel_medium'},
  {'icon': SBBIcons.hourglass_medium, 'name': 'hourglass_medium'},
  {'icon': SBBIcons.house_medium, 'name': 'house_medium'},
  {'icon': SBBIcons.id_card_employee_medium, 'name': 'id_card_employee_medium'},
  {'icon': SBBIcons.increase_size_medium, 'name': 'increase_size_medium'},
  {'icon': SBBIcons.k_r_medium, 'name': 'k_r_medium'},
  {'icon': SBBIcons.key_medium, 'name': 'key_medium'},
  {'icon': SBBIcons.keyboard_medium, 'name': 'keyboard_medium'},
  {'icon': SBBIcons.laptop_medium, 'name': 'laptop_medium'},
  {
    'icon': SBBIcons.laptop_smartphone_medium,
    'name': 'laptop_smartphone_medium'
  },
  {'icon': SBBIcons.layers_medium, 'name': 'layers_medium'},
  {'icon': SBBIcons.lcar_power_plug_medium, 'name': 'lcar_power_plug_medium'},
  {'icon': SBBIcons.lift_medium, 'name': 'lift_medium'},
  {'icon': SBBIcons.lighthouse_medium, 'name': 'lighthouse_medium'},
  {'icon': SBBIcons.link_external_medium, 'name': 'link_external_medium'},
  {'icon': SBBIcons.link_medium, 'name': 'link_medium'},
  {'icon': SBBIcons.lips_hand_medium, 'name': 'lips_hand_medium'},
  {'icon': SBBIcons.list_medium, 'name': 'list_medium'},
  {'icon': SBBIcons.location_pin_a_medium, 'name': 'location_pin_a_medium'},
  {'icon': SBBIcons.location_pin_b_medium, 'name': 'location_pin_b_medium'},
  {
    'icon': SBBIcons.location_pin_camera_medium,
    'name': 'location_pin_camera_medium'
  },
  {'icon': SBBIcons.location_pin_map_medium, 'name': 'location_pin_map_medium'},
  {'icon': SBBIcons.location_pin_medium, 'name': 'location_pin_medium'},
  {
    'icon': SBBIcons.location_pin_pulse_surrounding_area_medium,
    'name': 'location_pin_pulse_surrounding_area_medium'
  },
  {
    'icon': SBBIcons.location_pin_surrounding_area_medium,
    'name': 'location_pin_surrounding_area_medium'
  },
  {
    'icon': SBBIcons.location_pin_surrounding_area_power_plug_medium,
    'name': 'location_pin_surrounding_area_power_plug_medium'
  },
  {'icon': SBBIcons.lock_closed_medium, 'name': 'lock_closed_medium'},
  {'icon': SBBIcons.lock_open_medium, 'name': 'lock_open_medium'},
  {'icon': SBBIcons.locker_medium, 'name': 'locker_medium'},
  {
    'icon': SBBIcons.locomotive_high_speed_medium,
    'name': 'locomotive_high_speed_medium'
  },
  {'icon': SBBIcons.locomotive_medium, 'name': 'locomotive_medium'},
  {
    'icon': SBBIcons.locomotive_profile_moon_medium,
    'name': 'locomotive_profile_moon_medium'
  },
  {
    'icon': SBBIcons.long_distance_coach_profile_medium,
    'name': 'long_distance_coach_profile_medium'
  },
  {'icon': SBBIcons.lotus_medium, 'name': 'lotus_medium'},
  {'icon': SBBIcons.low_vision_medium, 'name': 'low_vision_medium'},
  {'icon': SBBIcons.magnifying_glass_medium, 'name': 'magnifying_glass_medium'},
  {
    'icon': SBBIcons.magnifying_glass_minus_medium,
    'name': 'magnifying_glass_minus_medium'
  },
  {
    'icon': SBBIcons.magnifying_glass_plus_medium,
    'name': 'magnifying_glass_plus_medium'
  },
  {'icon': SBBIcons.medical_facility_medium, 'name': 'medical_facility_medium'},
  {'icon': SBBIcons.meeting_point_medium, 'name': 'meeting_point_medium'},
  {'icon': SBBIcons.megaphone_medium, 'name': 'megaphone_medium'},
  {'icon': SBBIcons.metadata_medium, 'name': 'metadata_medium'},
  {'icon': SBBIcons.microphone_medium, 'name': 'microphone_medium'},
  {
    'icon': SBBIcons.microscooter_profile_medium,
    'name': 'microscooter_profile_medium'
  },
  {
    'icon': SBBIcons.microscooter_profile_power_plug_medium,
    'name': 'microscooter_profile_power_plug_medium'
  },
  {
    'icon': SBBIcons.milk_brick_disabled_medium,
    'name': 'milk_brick_disabled_medium'
  },
  {'icon': SBBIcons.minus_medium, 'name': 'minus_medium'},
  {'icon': SBBIcons.money_exchange_medium, 'name': 'money_exchange_medium'},
  {'icon': SBBIcons.moon_medium, 'name': 'moon_medium'},
  {
    'icon': SBBIcons.mountain_lake_sun_medium,
    'name': 'mountain_lake_sun_medium'
  },
  {'icon': SBBIcons.mountain_minus_medium, 'name': 'mountain_minus_medium'},
  {'icon': SBBIcons.mountain_plus_medium, 'name': 'mountain_plus_medium'},
  {'icon': SBBIcons.mountain_sun_medium, 'name': 'mountain_sun_medium'},
  {'icon': SBBIcons.moving_bus_medium, 'name': 'moving_bus_medium'},
  {'icon': SBBIcons.mug_hot_medium, 'name': 'mug_hot_medium'},
  {'icon': SBBIcons.music_notes_medium, 'name': 'music_notes_medium'},
  {'icon': SBBIcons.narcotic_medium, 'name': 'narcotic_medium'},
  {'icon': SBBIcons.network_medium, 'name': 'network_medium'},
  {'icon': SBBIcons.newspaper_medium, 'name': 'newspaper_medium'},
  {'icon': SBBIcons.next_medium, 'name': 'next_medium'},
  {'icon': SBBIcons.nine_squares_medium, 'name': 'nine_squares_medium'},
  {'icon': SBBIcons.office_chair_medium, 'name': 'office_chair_medium'},
  {'icon': SBBIcons.onboarding_medium, 'name': 'onboarding_medium'},
  {'icon': SBBIcons.paper_aeroplane_medium, 'name': 'paper_aeroplane_medium'},
  {'icon': SBBIcons.paper_clip_medium, 'name': 'paper_clip_medium'},
  {'icon': SBBIcons.park_and_rail_medium, 'name': 'park_and_rail_medium'},
  {'icon': SBBIcons.parliament_medium, 'name': 'parliament_medium'},
  {'icon': SBBIcons.pause_medium, 'name': 'pause_medium'},
  {'icon': SBBIcons.pen_medium, 'name': 'pen_medium'},
  {'icon': SBBIcons.percent_medium, 'name': 'percent_medium'},
  {'icon': SBBIcons.percent_tag_medium, 'name': 'percent_tag_medium'},
  {'icon': SBBIcons.petrol_station_medium, 'name': 'petrol_station_medium'},
  {'icon': SBBIcons.picture_medium, 'name': 'picture_medium'},
  {'icon': SBBIcons.pie_medium, 'name': 'pie_medium'},
  {'icon': SBBIcons.piggy_bank_medium, 'name': 'piggy_bank_medium'},
  {'icon': SBBIcons.pin_medium, 'name': 'pin_medium'},
  {'icon': SBBIcons.pizza_slice_medium, 'name': 'pizza_slice_medium'},
  {'icon': SBBIcons.platform_display_medium, 'name': 'platform_display_medium'},
  {'icon': SBBIcons.play_medium, 'name': 'play_medium'},
  {'icon': SBBIcons.plus_medium, 'name': 'plus_medium'},
  {'icon': SBBIcons.power_plug_medium, 'name': 'power_plug_medium'},
  {'icon': SBBIcons.pretzel_medium, 'name': 'pretzel_medium'},
  {'icon': SBBIcons.previous_medium, 'name': 'previous_medium'},
  {'icon': SBBIcons.printer_medium, 'name': 'printer_medium'},
  {'icon': SBBIcons.punctuality_medium, 'name': 'punctuality_medium'},
  {'icon': SBBIcons.qrcode_disabled_medium, 'name': 'qrcode_disabled_medium'},
  {
    'icon': SBBIcons.qrcode_disabled_two_tickets_medium,
    'name': 'qrcode_disabled_two_tickets_medium'
  },
  {'icon': SBBIcons.qrcode_medium, 'name': 'qrcode_medium'},
  {
    'icon': SBBIcons.qrcode_two_tickets_medium,
    'name': 'qrcode_two_tickets_medium'
  },
  {'icon': SBBIcons.question_answer_medium, 'name': 'question_answer_medium'},
  {'icon': SBBIcons.question_mark_medium, 'name': 'question_mark_medium'},
  {
    'icon': SBBIcons.rack_railaway_profile_medium,
    'name': 'rack_railaway_profile_medium'
  },
  {'icon': SBBIcons.railway_switch_medium, 'name': 'railway_switch_medium'},
  {'icon': SBBIcons.ramp_user_medium, 'name': 'ramp_user_medium'},
  {'icon': SBBIcons.record_medium, 'name': 'record_medium'},
  {'icon': SBBIcons.reduce_size_medium, 'name': 'reduce_size_medium'},
  {'icon': SBBIcons.rewind_medium, 'name': 'rewind_medium'},
  {'icon': SBBIcons.robot_medium, 'name': 'robot_medium'},
  {'icon': SBBIcons.roof_bed_medium, 'name': 'roof_bed_medium'},
  {'icon': SBBIcons.route_circle_end_medium, 'name': 'route_circle_end_medium'},
  {
    'icon': SBBIcons.route_circle_start_medium,
    'name': 'route_circle_start_medium'
  },
  {'icon': SBBIcons.rss_medium, 'name': 'rss_medium'},
  {'icon': SBBIcons.scanner_medium, 'name': 'scanner_medium'},
  {'icon': SBBIcons.scooter_profile_medium, 'name': 'scooter_profile_medium'},
  {
    'icon': SBBIcons.scooter_profile_power_plug_medium,
    'name': 'scooter_profile_power_plug_medium'
  },
  {
    'icon': SBBIcons.screen_inside_train_medium,
    'name': 'screen_inside_train_medium'
  },
  {'icon': SBBIcons.seat_medium, 'name': 'seat_medium'},
  {'icon': SBBIcons.seat_window_medium, 'name': 'seat_window_medium'},
  {'icon': SBBIcons.service_bell_medium, 'name': 'service_bell_medium'},
  {'icon': SBBIcons.share_medium, 'name': 'share_medium'},
  {
    'icon': SBBIcons.ship_steering_wheel_medium,
    'name': 'ship_steering_wheel_medium'
  },
  {'icon': SBBIcons.shirt_shoe_medium, 'name': 'shirt_shoe_medium'},
  {
    'icon': SBBIcons.shopping_bag_coupon_medium,
    'name': 'shopping_bag_coupon_medium'
  },
  {
    'icon': SBBIcons.shopping_bag_fast_medium,
    'name': 'shopping_bag_fast_medium'
  },
  {'icon': SBBIcons.shopping_bag_medium, 'name': 'shopping_bag_medium'},
  {'icon': SBBIcons.shopping_cart_medium, 'name': 'shopping_cart_medium'},
  {'icon': SBBIcons.shuttle_medium, 'name': 'shuttle_medium'},
  {
    'icon': SBBIcons.sign_exclamation_point_medium,
    'name': 'sign_exclamation_point_medium'
  },
  {'icon': SBBIcons.sign_parking_medium, 'name': 'sign_parking_medium'},
  {'icon': SBBIcons.sign_x_medium, 'name': 'sign_x_medium'},
  {'icon': SBBIcons.skis_ski_poles_medium, 'name': 'skis_ski_poles_medium'},
  {'icon': SBBIcons.smartphone_medium, 'name': 'smartphone_medium'},
  {
    'icon': SBBIcons.smartphone_shaking_medium,
    'name': 'smartphone_shaking_medium'
  },
  {'icon': SBBIcons.spanner_medium, 'name': 'spanner_medium'},
  {'icon': SBBIcons.speaker_medium, 'name': 'speaker_medium'},
  {
    'icon': SBBIcons.speech_bubble_group_empty_medium,
    'name': 'speech_bubble_group_empty_medium'
  },
  {'icon': SBBIcons.speech_bubble_medium, 'name': 'speech_bubble_medium'},
  {'icon': SBBIcons.stairs_user_medium, 'name': 'stairs_user_medium'},
  {'icon': SBBIcons.star_medium, 'name': 'star_medium'},
  {'icon': SBBIcons.station_medium, 'name': 'station_medium'},
  {
    'icon': SBBIcons.station_surrounding_area_medium,
    'name': 'station_surrounding_area_medium'
  },
  {'icon': SBBIcons.stop_medium, 'name': 'stop_medium'},
  {
    'icon': SBBIcons.street_location_pin_medium,
    'name': 'street_location_pin_medium'
  },
  {
    'icon': SBBIcons.suitcase_disabled_medium,
    'name': 'suitcase_disabled_medium'
  },
  {'icon': SBBIcons.suitcase_medium, 'name': 'suitcase_medium'},
  {'icon': SBBIcons.sun_moon_medium, 'name': 'sun_moon_medium'},
  {'icon': SBBIcons.sunrise_medium, 'name': 'sunrise_medium'},
  {
    'icon': SBBIcons.sunshade_sun_sand_medium,
    'name': 'sunshade_sun_sand_medium'
  },
  {'icon': SBBIcons.sunshine_medium, 'name': 'sunshine_medium'},
  {'icon': SBBIcons.swisspass_medium, 'name': 'swisspass_medium'},
  {
    'icon': SBBIcons.swisspass_temporary_medium,
    'name': 'swisspass_temporary_medium'
  },
  {'icon': SBBIcons.switzerland_medium, 'name': 'switzerland_medium'},
  {
    'icon': SBBIcons.switzerland_route_medium,
    'name': 'switzerland_route_medium'
  },
  {'icon': SBBIcons.tablet_medium, 'name': 'tablet_medium'},
  {
    'icon': SBBIcons.tablet_smartphone_medium,
    'name': 'tablet_smartphone_medium'
  },
  {'icon': SBBIcons.tag_medium, 'name': 'tag_medium'},
  {'icon': SBBIcons.target_medium, 'name': 'target_medium'},
  {'icon': SBBIcons.taxi_medium, 'name': 'taxi_medium'},
  {'icon': SBBIcons.taxi_profile_medium, 'name': 'taxi_profile_medium'},
  {'icon': SBBIcons.telephone_gsm_medium, 'name': 'telephone_gsm_medium'},
  {
    'icon': SBBIcons.telephone_receiver_medium,
    'name': 'telephone_receiver_medium'
  },
  {'icon': SBBIcons.three_gears_medium, 'name': 'three_gears_medium'},
  {'icon': SBBIcons.thumb_down_medium, 'name': 'thumb_down_medium'},
  {'icon': SBBIcons.thumb_up_medium, 'name': 'thumb_up_medium'},
  {'icon': SBBIcons.tick_medium, 'name': 'tick_medium'},
  {'icon': SBBIcons.ticket_day_medium, 'name': 'ticket_day_medium'},
  {'icon': SBBIcons.ticket_disabled_medium, 'name': 'ticket_disabled_medium'},
  {'icon': SBBIcons.ticket_fv_medium, 'name': 'ticket_fv_medium'},
  {'icon': SBBIcons.ticket_heart_medium, 'name': 'ticket_heart_medium'},
  {'icon': SBBIcons.ticket_ipv_medium, 'name': 'ticket_ipv_medium'},
  {'icon': SBBIcons.ticket_journey_medium, 'name': 'ticket_journey_medium'},
  {'icon': SBBIcons.ticket_machine_medium, 'name': 'ticket_machine_medium'},
  {
    'icon': SBBIcons.ticket_machine_ticket_medium,
    'name': 'ticket_machine_ticket_medium'
  },
  {'icon': SBBIcons.ticket_moon_star_medium, 'name': 'ticket_moon_star_medium'},
  {'icon': SBBIcons.ticket_parking_medium, 'name': 'ticket_parking_medium'},
  {'icon': SBBIcons.ticket_percent_medium, 'name': 'ticket_percent_medium'},
  {'icon': SBBIcons.ticket_route_medium, 'name': 'ticket_route_medium'},
  {'icon': SBBIcons.ticket_rv_medium, 'name': 'ticket_rv_medium'},
  {'icon': SBBIcons.ticket_star_medium, 'name': 'ticket_star_medium'},
  {'icon': SBBIcons.tickets_class_medium, 'name': 'tickets_class_medium'},
  {'icon': SBBIcons.timetable_medium, 'name': 'timetable_medium'},
  {'icon': SBBIcons.toilet_medium, 'name': 'toilet_medium'},
  {'icon': SBBIcons.torch_medium, 'name': 'torch_medium'},
  {'icon': SBBIcons.train_medium, 'name': 'train_medium'},
  {'icon': SBBIcons.train_profile_medium, 'name': 'train_profile_medium'},
  {'icon': SBBIcons.train_signal_medium, 'name': 'train_signal_medium'},
  {'icon': SBBIcons.train_station_medium, 'name': 'train_station_medium'},
  {
    'icon': SBBIcons.train_tracks_horizontal_medium,
    'name': 'train_tracks_horizontal_medium'
  },
  {'icon': SBBIcons.train_tracks_medium, 'name': 'train_tracks_medium'},
  {'icon': SBBIcons.tram_medium, 'name': 'tram_medium'},
  {'icon': SBBIcons.tram_profile_medium, 'name': 'tram_profile_medium'},
  {'icon': SBBIcons.translate_medium, 'name': 'translate_medium'},
  {'icon': SBBIcons.trash_medium, 'name': 'trash_medium'},
  {'icon': SBBIcons.travel_backpack_medium, 'name': 'travel_backpack_medium'},
  {'icon': SBBIcons.tree_medium, 'name': 'tree_medium'},
  {'icon': SBBIcons.two_adults_kid_medium, 'name': 'two_adults_kid_medium'},
  {'icon': SBBIcons.two_finger_tap_medium, 'name': 'two_finger_tap_medium'},
  {'icon': SBBIcons.two_folders_medium, 'name': 'two_folders_medium'},
  {
    'icon': SBBIcons.two_speech_bubbles_medium,
    'name': 'two_speech_bubbles_medium'
  },
  {'icon': SBBIcons.two_users_medium, 'name': 'two_users_medium'},
  {
    'icon': SBBIcons.underground_vehicule_profile_medium,
    'name': 'underground_vehicule_profile_medium'
  },
  {'icon': SBBIcons.upload_medium, 'name': 'upload_medium'},
  {'icon': SBBIcons.user_change_medium, 'name': 'user_change_medium'},
  {'icon': SBBIcons.user_group_medium, 'name': 'user_group_medium'},
  {
    'icon': SBBIcons.user_group_round_table_medium,
    'name': 'user_group_round_table_medium'
  },
  {'icon': SBBIcons.user_group_row_medium, 'name': 'user_group_row_medium'},
  {'icon': SBBIcons.user_hat_medium, 'name': 'user_hat_medium'},
  {
    'icon': SBBIcons.user_headset_display_medium,
    'name': 'user_headset_display_medium'
  },
  {'icon': SBBIcons.user_headset_medium, 'name': 'user_headset_medium'},
  {'icon': SBBIcons.user_key_medium, 'name': 'user_key_medium'},
  {'icon': SBBIcons.user_medium, 'name': 'user_medium'},
  {'icon': SBBIcons.user_plus_medium, 'name': 'user_plus_medium'},
  {'icon': SBBIcons.user_tie_medium, 'name': 'user_tie_medium'},
  {'icon': SBBIcons.vegan_medium, 'name': 'vegan_medium'},
  {'icon': SBBIcons.vegetarian_medium, 'name': 'vegetarian_medium'},
  {'icon': SBBIcons.wagon_medium, 'name': 'wagon_medium'},
  {'icon': SBBIcons.waiting_room_medium, 'name': 'waiting_room_medium'},
  {'icon': SBBIcons.walk_fast_medium, 'name': 'walk_fast_medium'},
  {'icon': SBBIcons.walk_large_medium, 'name': 'walk_large_medium'},
  {'icon': SBBIcons.walk_medium, 'name': 'walk_medium'},
  {'icon': SBBIcons.walk_slow_medium, 'name': 'walk_slow_medium'},
  {'icon': SBBIcons.walkie_talkie_medium, 'name': 'walkie_talkie_medium'},
  {'icon': SBBIcons.wallet_medium, 'name': 'wallet_medium'},
  {'icon': SBBIcons.warning_light_medium, 'name': 'warning_light_medium'},
  {'icon': SBBIcons.washing_machine_medium, 'name': 'washing_machine_medium'},
  {'icon': SBBIcons.waves_ladder_medium, 'name': 'waves_ladder_medium'},
  {'icon': SBBIcons.weather_unknown_medium, 'name': 'weather_unknown_medium'},
  {'icon': SBBIcons.weight_medium, 'name': 'weight_medium'},
  {
    'icon': SBBIcons.wheelchair_inaccessible_medium,
    'name': 'wheelchair_inaccessible_medium'
  },
  {'icon': SBBIcons.wheelchair_medium, 'name': 'wheelchair_medium'},
  {
    'icon': SBBIcons.wheelchair_partially_medium,
    'name': 'wheelchair_partially_medium'
  },
  {
    'icon': SBBIcons.wheelchair_reservation_medium,
    'name': 'wheelchair_reservation_medium'
  },
  {
    'icon': SBBIcons.wheelchair_uncertain_medium,
    'name': 'wheelchair_uncertain_medium'
  },
  {'icon': SBBIcons.wifi_disabled_medium, 'name': 'wifi_disabled_medium'},
  {'icon': SBBIcons.wifi_medium, 'name': 'wifi_medium'},
  {'icon': SBBIcons.wine_cheese_medium, 'name': 'wine_cheese_medium'},
];

const iconsLarge = [
  {'icon': SBBIcons.adult_kids_large, 'name': 'adult_kids_large'},
  {'icon': SBBIcons.balloons_large, 'name': 'balloons_large'},
  {'icon': SBBIcons.bicycle_large, 'name': 'bicycle_large'},
  {
    'icon': SBBIcons.bicycle_profile_user_group_circle_large,
    'name': 'bicycle_profile_user_group_circle_large'
  },
  {'icon': SBBIcons.binoculars_large, 'name': 'binoculars_large'},
  {
    'icon': SBBIcons.bluetooth_disabled_large,
    'name': 'bluetooth_disabled_large'
  },
  {'icon': SBBIcons.bluetooth_large, 'name': 'bluetooth_large'},
  {'icon': SBBIcons.building_tree_large, 'name': 'building_tree_large'},
  {'icon': SBBIcons.bulb_on_large, 'name': 'bulb_on_large'},
  {'icon': SBBIcons.calendar_large, 'name': 'calendar_large'},
  {'icon': SBBIcons.calendar_one_day_large, 'name': 'calendar_one_day_large'},
  {'icon': SBBIcons.car_profile_large, 'name': 'car_profile_large'},
  {
    'icon': SBBIcons.car_profile_power_plug_large,
    'name': 'car_profile_power_plug_large'
  },
  {
    'icon': SBBIcons.car_profile_sign_parking_large,
    'name': 'car_profile_sign_parking_large'
  },
  {
    'icon': SBBIcons.car_profile_user_group_circle_large,
    'name': 'car_profile_user_group_circle_large'
  },
  {
    'icon': SBBIcons.certificate_ribbon_large,
    'name': 'certificate_ribbon_large'
  },
  {
    'icon': SBBIcons.chart_column_trend_large,
    'name': 'chart_column_trend_large'
  },
  {
    'icon': SBBIcons.christmas_tree_shopping_bag_large,
    'name': 'christmas_tree_shopping_bag_large'
  },
  {'icon': SBBIcons.circle_cross_large, 'name': 'circle_cross_large'},
  {
    'icon': SBBIcons.circle_information_large,
    'name': 'circle_information_large'
  },
  {
    'icon': SBBIcons.circle_triangle_square_large,
    'name': 'circle_triangle_square_large'
  },
  {'icon': SBBIcons.city_large, 'name': 'city_large'},
  {'icon': SBBIcons.clock_large, 'name': 'clock_large'},
  {'icon': SBBIcons.coins_large, 'name': 'coins_large'},
  {'icon': SBBIcons.curriculum_vitae_large, 'name': 'curriculum_vitae_large'},
  {'icon': SBBIcons.elephant_large, 'name': 'elephant_large'},
  {'icon': SBBIcons.employees_sbb_large, 'name': 'employees_sbb_large'},
  {'icon': SBBIcons.envelope_large, 'name': 'envelope_large'},
  {'icon': SBBIcons.envelope_open_large, 'name': 'envelope_open_large'},
  {'icon': SBBIcons.ferris_wheel_large, 'name': 'ferris_wheel_large'},
  {'icon': SBBIcons.gps_disabled_large, 'name': 'gps_disabled_large'},
  {'icon': SBBIcons.gps_large, 'name': 'gps_large'},
  {
    'icon': SBBIcons.hand_graduation_cap_large,
    'name': 'hand_graduation_cap_large'
  },
  {'icon': SBBIcons.hand_plus_circle_large, 'name': 'hand_plus_circle_large'},
  {'icon': SBBIcons.handshake_large, 'name': 'handshake_large'},
  {'icon': SBBIcons.hiking_boot_large, 'name': 'hiking_boot_large'},
  {'icon': SBBIcons.laptop_smartphone_large, 'name': 'laptop_smartphone_large'},
  {'icon': SBBIcons.leaf_large, 'name': 'leaf_large'},
  {
    'icon': SBBIcons.location_pin_surrounding_area_power_plug_large,
    'name': 'location_pin_surrounding_area_power_plug_large'
  },
  {
    'icon': SBBIcons.locomotive_viaduct_large,
    'name': 'locomotive_viaduct_large'
  },
  {'icon': SBBIcons.lotus_large, 'name': 'lotus_large'},
  {
    'icon': SBBIcons.lucerne_chapel_bridge_large,
    'name': 'lucerne_chapel_bridge_large'
  },
  {
    'icon': SBBIcons.magnifying_glass_minus_large,
    'name': 'magnifying_glass_minus_large'
  },
  {
    'icon': SBBIcons.magnifying_glass_plus_large,
    'name': 'magnifying_glass_plus_large'
  },
  {
    'icon': SBBIcons.market_shopping_bag_large,
    'name': 'market_shopping_bag_large'
  },
  {'icon': SBBIcons.mountain_sun_large, 'name': 'mountain_sun_large'},
  {'icon': SBBIcons.museum_large, 'name': 'museum_large'},
  {
    'icon': SBBIcons.music_rock_hand_gesture_large,
    'name': 'music_rock_hand_gesture_large'
  },
  {'icon': SBBIcons.network_large, 'name': 'network_large'},
  {'icon': SBBIcons.paper_aeroplane_large, 'name': 'paper_aeroplane_large'},
  {'icon': SBBIcons.paper_clip_large, 'name': 'paper_clip_large'},
  {'icon': SBBIcons.percent_large, 'name': 'percent_large'},
  {'icon': SBBIcons.piggy_bank_large, 'name': 'piggy_bank_large'},
  {'icon': SBBIcons.platform_large, 'name': 'platform_large'},
  {'icon': SBBIcons.punctuality_large, 'name': 'punctuality_large'},
  {'icon': SBBIcons.railway_ship_large, 'name': 'railway_ship_large'},
  {'icon': SBBIcons.railway_switch_large, 'name': 'railway_switch_large'},
  {'icon': SBBIcons.rocket_large, 'name': 'rocket_large'},
  {'icon': SBBIcons.shopping_cart_large, 'name': 'shopping_cart_large'},
  {'icon': SBBIcons.sign_parking_large, 'name': 'sign_parking_large'},
  {'icon': SBBIcons.sledge_snowshoe_large, 'name': 'sledge_snowshoe_large'},
  {'icon': SBBIcons.smartphone_large, 'name': 'smartphone_large'},
  {'icon': SBBIcons.soccer_ball_large, 'name': 'soccer_ball_large'},
  {'icon': SBBIcons.station_large, 'name': 'station_large'},
  {'icon': SBBIcons.sunshade_sun_sand_large, 'name': 'sunshade_sun_sand_large'},
  {'icon': SBBIcons.switzerland_route_large, 'name': 'switzerland_route_large'},
  {'icon': SBBIcons.target_large, 'name': 'target_large'},
  {'icon': SBBIcons.taxi_profile_large, 'name': 'taxi_profile_large'},
  {'icon': SBBIcons.three_adults_large, 'name': 'three_adults_large'},
  {'icon': SBBIcons.train_large, 'name': 'train_large'},
  {'icon': SBBIcons.train_profile_large, 'name': 'train_profile_large'},
  {'icon': SBBIcons.train_signal_large, 'name': 'train_signal_large'},
  {'icon': SBBIcons.train_ski_large, 'name': 'train_ski_large'},
  {'icon': SBBIcons.train_tracks_large, 'name': 'train_tracks_large'},
  {'icon': SBBIcons.two_adults_kid_large, 'name': 'two_adults_kid_large'},
  {
    'icon': SBBIcons.two_speech_bubbles_large,
    'name': 'two_speech_bubbles_large'
  },
  {'icon': SBBIcons.user_group_large, 'name': 'user_group_large'},
];
