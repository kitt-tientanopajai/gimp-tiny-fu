;; kitty.in.th-contrast-mask.scm
;; v. 0.04
;; Author Kitt Tientanopajai <kitty@kitty.in.th>
;; Copyright (C) 2005 Kitt Tientanopajai"
;;
;; This is a free software and can be redistributed under GNU GPL version 2.
;; 
;; This script performs contrast mask on an image.
;;
;; ChangeLogs
;; v. 0.04 - Mon, 15 Dec 2008 22:38:12 +0700
;; - Move to Filters menu

(define (kitty.in.th-contrast-mask image drawable)
	(let* (
		(mask-layer (car (gimp-layer-new-from-drawable drawable image))))

		(gimp-image-undo-group-start image)
		(gimp-layer-set-name mask-layer "kitty.in.th - contrast mask")
		(gimp-layer-set-mode mask-layer OVERLAY)
		(gimp-image-add-layer image mask-layer -1)
		(gimp-desaturate mask-layer)
		(gimp-invert mask-layer)
		(gimp-displays-flush)
		(gimp-image-undo-group-end image)))

(script-fu-register
	"kitty.in.th-contrast-mask"
	"<Image>/Filters/kitty.in.th/Contrast Mask"
	"kitty.in.th contrast mask v.0.04"
	"Kitt Tientanopajai"
	"Copyright (C) 2005-2008 Kitt Tientanopajai"
	"December 15, 2008"
	"RGB RGBA GRAY GRAYA"
	SF-IMAGE "Image" 0
	SF-DRAWABLE "Drawable" 0)
