variable "settings" {
  type = object({
    categories = optional(object({
      auth = optional(object({
        authMethodOrder = optional(list(list(object({
          display = string
          type    = string
          }))), [[
          {
            display = "BUTTON"
            type    = "FEDERATED"
          },
          {
            display = "INPUT"
            type    = "USERNAME_PASSWORD"
          }
        ]])
        federation = optional(object({
          interfaceStyle = optional(string, "BUTTON_LIST")
          order          = optional(list(string), [])
        }), {})
      }), {})
      form = optional(object({
        displayGraphics = optional(bool, true)
        instructions = optional(object({
          enabled = optional(bool, false)
        }), {})
        languageSelector = optional(object({
          enabled = optional(bool, false)
        }), {})
        location = optional(object({
          horizontal = optional(string, "CENTER")
          vertical   = optional(string, "CENTER")
        }), {})
        sessionTimerDisplay = optional(string, "NONE")
      }), {})
      global = optional(object({
        colorSchemeMode = optional(string, "LIGHT")
        pageFooter = optional(object({
          enabled = optional(bool, false)
        }), {})
        pageHeader = optional(object({
          enabled = optional(bool, false)
        }), {})
        spacingDensity = optional(string, "REGULAR")
      }), {})
      signUp = optional(object({
        acceptanceElements = optional(list(object({
          enforcement = string
          textKey     = string
          })), [{
          enforcement = "NONE"
          textKey     = "en"
        }])
      }), {})
    }), {})
    componentClasses = optional(object({
      buttons = optional(object({
        borderRadius = optional(number, 8)
      }), {})
      divider = optional(object({
        darkMode = optional(object({
          borderColor = optional(string, "232b37ff")
        }), {})
        lightMode = optional(object({
          borderColor = optional(string, "ebebf0ff")
        }), {})
      }), {})
      dropDown = optional(object({
        borderRadius = optional(number, 8)
        darkMode = optional(object({
          defaults = optional(object({
            itemBackgroundColor = optional(string, "192534ff")
          }), {})
          hover = optional(object({
            itemBackgroundColor = optional(string, "081120ff")
            itemBorderColor     = optional(string, "5f6b7aff")
            itemTextColor       = optional(string, "e9ebedff")
          }), {})
          match = optional(object({
            itemBackgroundColor = optional(string, "d1d5dbff")
            itemTextColor       = optional(string, "89bdeeff")
          }), {})
        }), {})
        lightMode = optional(object({
          defaults = optional(object({
            itemBackgroundColor = optional(string, "ffffffff")
          }), {})
          hover = optional(object({
            itemBackgroundColor = optional(string, "f4f4f4ff")
            itemBorderColor     = optional(string, "7d8998ff")
            itemTextColor       = optional(string, "000716ff")
          }), {})
          match = optional(object({
            itemBackgroundColor = optional(string, "414d5cff")
            itemTextColor       = optional(string, "0972d3ff")
          }), {})
        }), {})
      }), {})
      focusState = optional(object({
        darkMode = optional(object({
          borderColor = optional(string, "539fe5ff")
        }), {})
        lightMode = optional(object({
          borderColor = optional(string, "0972d3ff")
        }), {})
      }), {})
      idpButtons = optional(object({
        icons = optional(object({
          enabled = optional(bool, true)
        }), {})
      }), {})
      input = optional(object({
        borderRadius = optional(number, 8)
        darkMode = optional(object({
          defaults = optional(object({
            backgroundColor = optional(string, "0f1b2aff")
            borderColor     = optional(string, "5f6b7aff")
          }), {})
          placeholderColor = optional(string, "8d99a8ff")
        }), {})
        lightMode = optional(object({
          defaults = optional(object({
            backgroundColor = optional(string, "ffffffff")
            borderColor     = optional(string, "7d8998ff")
          }), {})
          placeholderColor = optional(string, "5f6b7aff")
        }), {})
      }), {})
      inputDescription = optional(object({
        darkMode = optional(object({
          textColor = optional(string, "8d99a8ff")
        }), {})
        lightMode = optional(object({
          textColor = optional(string, "5f6b7aff")
        }), {})
      }), {})
      inputLabel = optional(object({
        darkMode = optional(object({
          textColor = optional(string, "d1d5dbff")
        }), {})
        lightMode = optional(object({
          textColor = optional(string, "000716ff")
        }), {})
      }), {})
      link = optional(object({
        darkMode = optional(object({
          defaults = optional(object({
            textColor = optional(string, "539fe5ff")
          }), {})
          hover = optional(object({
            textColor = optional(string, "89bdeeff")
          }), {})
        }), {})
        lightMode = optional(object({
          defaults = optional(object({
            textColor = optional(string, "0972d3ff")
          }), {})
          hover = optional(object({
            textColor = optional(string, "033160ff")
          }), {})
        }), {})
      }), {})
      optionControls = optional(object({
        darkMode = optional(object({
          defaults = optional(object({
            backgroundColor = optional(string, "0f1b2aff")
            borderColor     = optional(string, "7d8998ff")
          }), {})
          selected = optional(object({
            backgroundColor = optional(string, "539fe5ff")
            foregroundColor = optional(string, "000716ff")
          }), {})
        }), {})
        lightMode = optional(object({
          defaults = optional(object({
            backgroundColor = optional(string, "ffffffff")
            borderColor     = optional(string, "7d8998ff")
          }), {})
          selected = optional(object({
            backgroundColor = optional(string, "0972d3ff")
            foregroundColor = optional(string, "ffffffff")
          }), {})
        }), {})
      }), {})
      statusIndicator = optional(object({
        darkMode = optional(object({
          error = optional(object({
            backgroundColor = optional(string, "1a0000ff")
            borderColor     = optional(string, "eb6f6fff")
            indicatorColor  = optional(string, "eb6f6fff")
          }), {})
          pending = optional(object({
            indicatorColor = optional(string, "AAAAAAAA")
          }), {})
          success = optional(object({
            backgroundColor = optional(string, "001a02ff")
            borderColor     = optional(string, "29ad32ff")
            indicatorColor  = optional(string, "29ad32ff")
          }), {})
          warning = optional(object({
            backgroundColor = optional(string, "1d1906ff")
            borderColor     = optional(string, "e0ca57ff")
            indicatorColor  = optional(string, "e0ca57ff")
          }), {})
        }), {})
        lightMode = optional(object({
          error = optional(object({
            backgroundColor = optional(string, "fff7f7ff")
            borderColor     = optional(string, "d91515ff")
            indicatorColor  = optional(string, "d91515ff")
          }), {})
          pending = optional(object({
            indicatorColor = optional(string, "AAAAAAAA")
          }), {})
          success = optional(object({
            backgroundColor = optional(string, "f2fcf3ff")
            borderColor     = optional(string, "037f0cff")
            indicatorColor  = optional(string, "037f0cff")
          }), {})
          warning = optional(object({
            backgroundColor = optional(string, "fffce9ff")
            borderColor     = optional(string, "8d6605ff")
            indicatorColor  = optional(string, "8d6605ff")
          }), {})
        }), {})
      }), {})
    }), {})
    components = optional(object({
      alert = optional(object({
        borderRadius = optional(number, 12)
        darkMode = optional(object({
          error = optional(object({
            backgroundColor = optional(string, "1a0000ff")
            borderColor     = optional(string, "eb6f6fff")
          }), {})
        }), {})
        lightMode = optional(object({
          error = optional(object({
            backgroundColor = optional(string, "fff7f7ff")
            borderColor     = optional(string, "d91515ff")
          }), {})
        }), {})
      }), {})
      favicon = optional(object({
        enabledTypes = optional(list(string), ["ICO", "SVG"])
      }), {})
      form = optional(object({
        backgroundImage = optional(object({
          enabled = optional(bool, false)
        }), {})
        borderRadius = optional(number, 8)
        darkMode = optional(object({
          backgroundColor = optional(string, "0f1b2aff")
          borderColor     = optional(string, "424650ff")
        }), {})
        lightMode = optional(object({
          backgroundColor = optional(string, "ffffffff")
          borderColor     = optional(string, "c6c6cdff")
        }), {})
        logo = optional(object({
          enabled       = optional(bool, false)
          formInclusion = optional(string, "IN")
          location      = optional(string, "CENTER")
          position      = optional(string, "TOP")
        }), {})
      }), {})
      idpButton = optional(object({
        custom = optional(map(any), {})
        standard = optional(object({
          darkMode = optional(object({
            active = optional(object({
              backgroundColor = optional(string, "354150ff")
              borderColor     = optional(string, "89bdeeff")
              textColor       = optional(string, "89bdeeff")
            }), {})
            defaults = optional(object({
              backgroundColor = optional(string, "0f1b2aff")
              borderColor     = optional(string, "c6c6cdff")
              textColor       = optional(string, "c6c6cdff")
            }), {})
            hover = optional(object({
              backgroundColor = optional(string, "192534ff")
              borderColor     = optional(string, "89bdeeff")
              textColor       = optional(string, "89bdeeff")
            }), {})
          }), {})
          lightMode = optional(object({
            active = optional(object({
              backgroundColor = optional(string, "d3e7f9ff")
              borderColor     = optional(string, "033160ff")
              textColor       = optional(string, "033160ff")
            }), {})
            defaults = optional(object({
              backgroundColor = optional(string, "ffffffff")
              borderColor     = optional(string, "424650ff")
              textColor       = optional(string, "424650ff")
            }), {})
            hover = optional(object({
              backgroundColor = optional(string, "f2f8fdff")
              borderColor     = optional(string, "033160ff")
              textColor       = optional(string, "033160ff")
            }), {})
          }), {})
        }), {})
      }), {})
      pageBackground = optional(object({
        darkMode = optional(object({
          color = optional(string, "0f1b2aff")
        }), {})
        image = optional(object({
          enabled = optional(bool, true)
        }), {})
        lightMode = optional(object({
          color = optional(string, "ffffffff")
        }), {})
      }), {})
      pageFooter = optional(object({
        backgroundImage = optional(object({
          enabled = optional(bool, false)
        }), {})
        darkMode = optional(object({
          background = optional(object({
            color = optional(string, "0f141aff")
          }), {})
          borderColor = optional(string, "424650ff")
        }), {})
        lightMode = optional(object({
          background = optional(object({
            color = optional(string, "fafafaff")
          }), {})
          borderColor = optional(string, "d5dbdbff")
        }), {})
        logo = optional(object({
          enabled  = optional(bool, false)
          location = optional(string, "START")
        }), {})
      }), {})
      pageHeader = optional(object({
        backgroundImage = optional(object({
          enabled = optional(bool, false)
        }), {})
        darkMode = optional(object({
          background = optional(object({
            color = optional(string, "0f141aff")
          }), {})
          borderColor = optional(string, "424650ff")
        }), {})
        lightMode = optional(object({
          background = optional(object({
            color = optional(string, "fafafaff")
          }), {})
          borderColor = optional(string, "d5dbdbff")
        }), {})
        logo = optional(object({
          enabled  = optional(bool, false)
          location = optional(string, "START")
        }), {})
      }), {})
      pageText = optional(object({
        darkMode = optional(object({
          bodyColor        = optional(string, "b6bec9ff")
          descriptionColor = optional(string, "b6bec9ff")
          headingColor     = optional(string, "d1d5dbff")
        }), {})
        lightMode = optional(object({
          bodyColor        = optional(string, "414d5cff")
          descriptionColor = optional(string, "414d5cff")
          headingColor     = optional(string, "000716ff")
        }), {})
      }), {})
      phoneNumberSelector = optional(object({
        displayType = optional(string, "TEXT")
      }), {})
      primaryButton = optional(object({
        darkMode = optional(object({
          active = optional(object({
            backgroundColor = optional(string, "539fe5ff")
            textColor       = optional(string, "000716ff")
          }), {})
          defaults = optional(object({
            backgroundColor = optional(string, "539fe5ff")
            textColor       = optional(string, "000716ff")
          }), {})
          disabled = optional(object({
            backgroundColor = optional(string, "ffffffff")
            borderColor     = optional(string, "ffffffff")
          }), {})
          hover = optional(object({
            backgroundColor = optional(string, "89bdeeff")
            textColor       = optional(string, "000716ff")
          }), {})
        }), {})
        lightMode = optional(object({
          active = optional(object({
            backgroundColor = optional(string, "033160ff")
            textColor       = optional(string, "ffffffff")
          }), {})
          defaults = optional(object({
            backgroundColor = optional(string, "0972d3ff")
            textColor       = optional(string, "ffffffff")
          }), {})
          disabled = optional(object({
            backgroundColor = optional(string, "ffffffff")
            borderColor     = optional(string, "ffffffff")
          }), {})
          hover = optional(object({
            backgroundColor = optional(string, "033160ff")
            textColor       = optional(string, "ffffffff")
          }), {})
        }), {})
      }), {})
      secondaryButton = optional(object({
        darkMode = optional(object({
          active = optional(object({
            backgroundColor = optional(string, "354150ff")
            borderColor     = optional(string, "89bdeeff")
            textColor       = optional(string, "89bdeeff")
          }), {})
          defaults = optional(object({
            backgroundColor = optional(string, "0f1b2aff")
            borderColor     = optional(string, "539fe5ff")
            textColor       = optional(string, "539fe5ff")
          }), {})
          hover = optional(object({
            backgroundColor = optional(string, "192534ff")
            borderColor     = optional(string, "89bdeeff")
            textColor       = optional(string, "89bdeeff")
          }), {})
        }), {})
        lightMode = optional(object({
          active = optional(object({
            backgroundColor = optional(string, "d3e7f9ff")
            borderColor     = optional(string, "033160ff")
            textColor       = optional(string, "033160ff")
          }), {})
          defaults = optional(object({
            backgroundColor = optional(string, "ffffffff")
            borderColor     = optional(string, "0972d3ff")
            textColor       = optional(string, "0972d3ff")
          }), {})
          hover = optional(object({
            backgroundColor = optional(string, "f2f8fdff")
            borderColor     = optional(string, "033160ff")
            textColor       = optional(string, "033160ff")
          }), {})
        }), {})
      }), {})
    }), {})
  })
  description = "Cognito managed login branding settings"
  default     = {}
}
