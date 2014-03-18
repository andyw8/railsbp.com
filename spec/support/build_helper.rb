module Support
  module BuildHelper
    def build_analyze_success
      Build.any_instance.stubs(:system)
      Dir.stubs(:chdir)
      Build.any_instance.stubs(:last_errors).returns([])
      Build.any_instance.stubs(:current_errors).returns([])
      mailer = mock(:deliver)
      UserMailer.stubs(:notify_build_success).returns(mailer)
      File.stubs(:open)
      work_off
    end

    def build_analyze_failure
      Build.any_instance.stubs(:system)
      Dir.stubs(:chdir).raises()
      exception_notification = stub
      ExceptionNotifier::Notifier.expects(:background_exception_notification).returns(exception_notification)
      exception_notification.expects(:deliver)
      work_off
    end
  end
end
