//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <awesome_notifications/awesome_notifications_plugin.h>
#include <file_selector_linux/file_selector_plugin.h>
#include <flutter_native_html_to_pdf/flutter_native_html_to_pdf_plugin.h>
#include <http_interceptor_plus/http_interceptor_plus_plugin.h>
#include <url_launcher_linux/url_launcher_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) awesome_notifications_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "AwesomeNotificationsPlugin");
  awesome_notifications_plugin_register_with_registrar(awesome_notifications_registrar);
  g_autoptr(FlPluginRegistrar) file_selector_linux_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "FileSelectorPlugin");
  file_selector_plugin_register_with_registrar(file_selector_linux_registrar);
  g_autoptr(FlPluginRegistrar) flutter_native_html_to_pdf_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "FlutterNativeHtmlToPdfPlugin");
  flutter_native_html_to_pdf_plugin_register_with_registrar(flutter_native_html_to_pdf_registrar);
  g_autoptr(FlPluginRegistrar) http_interceptor_plus_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "HttpInterceptorPlusPlugin");
  http_interceptor_plus_plugin_register_with_registrar(http_interceptor_plus_registrar);
  g_autoptr(FlPluginRegistrar) url_launcher_linux_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "UrlLauncherPlugin");
  url_launcher_plugin_register_with_registrar(url_launcher_linux_registrar);
}