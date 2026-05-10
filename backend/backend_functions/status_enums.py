from enum import Enum

#status enums
class Status(Enum):
    SUCCESS = 1
    INVALID_EMAIL = 2
    INVALID_PASSWORD = 3
    EMAIL_ALREADY_EXISTS = 4