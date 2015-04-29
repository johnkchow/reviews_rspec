(function() {
  'use strict';

  var SignInFormView = Backbone.View.extend({
    events: {
      'click button': 'signIn',
      'submit form': 'signIn'
    },

    initialize: function(options) {
      this.alertView = options.alertView;
    },

    signIn: function(e) {
      e.preventDefault();
      var _this = this;
      $.post('/api/sessions',{
        email: this.$('input[name=email]').val(),
        password: this.$('input[name=password]').val()
      }).done(function() {
        _this.alertView.success("Authentication succeeded!");
      }).fail(function() {
        _this.alertView.error("Email/password combo failed.");
      });
    },

    render: function() {
      return this;
    }
  });

  var CreateFormView = Backbone.View.extend({
    events: {
      'click button': 'create',
      'submit form': 'create'
    },

    initialize: function(options) {
      this.alertView = options.alertView;
    },

    create: function(e) {
      e.preventDefault();
      var _this = this;
      $.post('/api/users',{
        user: {
          email: this.$('input[name=email]').val(),
          password: this.$('input[name=password]').val()
        }
      }).done(function() {
        _this.alertView.success("Authentication succeeded!");
      }).fail(function(xhr) {
        switch(xhr.status) {
          case 400:
            var data = JSON.parse(xhr.responseText);
            _this.alertView.error(data.errors.join(','));
            break;
          case 409:
            _this.alertView.error("Email is taken");
            break;
          default:
            _this.alertView.error("Some unknown error occurred");
            break;
        }
      });
    },

    render: function() {
      return this;
    }
  });

  var AlertView = Backbone.View.extend({
    initialize: function() {
      this.$el.hide();
    },

    success: function(message) {
      this.$el.attr('class', 'alert alert-success');
      this._setMessage(message);
    },

    error: function(message) {
      this.$el.attr('class', 'alert alert-danger');
      this._setMessage(message);
    },

    render: function() {
      return this;
    },

    _setMessage: function(msg) {
      this.$el.text(msg);
      this.$el.show();
    }
  });


  $(document).ready(function () {
    window.alertView = new AlertView({
      el: '.js_alert'
    });

    window.createFormView = new CreateFormView({
      el: '.js_create',
      alertView: alertView
    });

    window.formView = new SignInFormView({
      el: '.js_sign_in',
      alertView: alertView
    });
  });
})();
