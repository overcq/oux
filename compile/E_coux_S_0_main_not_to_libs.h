#include <stdbool.h>
#include <pthread.h>
#include <alloca.h>
#include <ctype.h>
#include <dlfcn.h>
#include <errno.h>
#include <error.h>
#include <fcntl.h>
#include <fenv.h>
#include <limits.h>
#include <locale.h>
#include <math.h>
#include <sched.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/file.h>
#include <sys/ipc.h>
#include <sys/mman.h>
#include <sys/prctl.h>
#include <sys/sem.h>
#include <sys/shm.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <termios.h>
#include <time.h>
#include <ucontext.h>
#include <unistd.h>
#include "E_coux_S_machine.h"
#include "E_coux_S_language.h"
enum
{ _F_uid( base_2fM ) = ( ~0 << ( sizeof(int) * 8 / 2 - 1 )) | 1
, _F_uid( base_2fW )
, _F_uid( base_2fflow_5fdrv )
, _F_uid( base_2fflow_5ffork )
, _F_uid( base_2fflow_5flog )
, _F_uid( base_2fio_5fout )
, _F_uid( base_2fmem_5fblk )
, _F_uid( base_2fmem_5ffile )
, _F_uid( base_2fmem_5fpage )
, _F_uid( base_2fmem_5ftab )
, _F_uid( base_2ftext )
};
#include "base/0.h"
#include "base/E_coux_S_1_flow_log.h"
#include "base/E_coux_S_1_text.h"
#include "base/E_coux_S_1_flow_fork.h"
#include "base/E_coux_S_1_mem_tab.h"
#include "base/E_coux_S_1_mem_file.h"
#include "base/E_coux_S_1_M.h"
#include "base/E_coux_S_1_mem_page.h"
#include "base/E_coux_S_1_io_out.h"
#include "base/E_coux_S_1_flow_drv.h"
#include "base/E_coux_S_1_W.h"
#include "base/E_coux_S_1_mem_blk.h"
#include "base/E_coux_S_2_flow_log.h"
#include "base/E_coux_S_2_text.h"
#include "base/E_coux_S_2_flow_fork.h"
#include "base/E_coux_S_2_mem_tab.h"
#include "base/E_coux_S_2_mem_file.h"
#include "base/E_coux_S_2_M.h"
#include "base/E_coux_S_2_mem_page.h"
#include "base/E_coux_S_2_io_out.h"
#include "base/E_coux_S_2_flow_drv.h"
#include "base/E_coux_S_2_W.h"
#include "base/E_coux_S_2_mem_blk.h"
